#!/bin/sh
#
# prune-nvidia-gpu.sh
#
# Prune a Linux drivers/gpu source tree down to the pieces useful for
# NVIDIA Nouveau/NVK and Nova development/porting.
#
# IMPORTANT:
#   - Run this from the Linux kernel's drivers/gpu directory.
#   - Default is DRY RUN. Nothing is deleted unless --apply is supplied.
#   - This is intended to create a compact source/porting tree.
#     It does NOT promise that the remaining tree can still be built as a
#     complete upstream Linux kernel without editing Kconfig/Makefiles.
#
# Kept:
#   ./Kconfig
#   ./Makefile
#   ./buddy.c
#   ./vga/            (small; Nouveau can reference VGA/switcheroo support)
#   ./trace/          (small generic GPU tracing support)
#   ./nova-core/      (Turing+ Nova/GSP path)
#   ./drm/            (common DRM source files)
#   ./drm/nouveau/    (Nouveau/NVK kernel path; needed for Pascal P4)
#   ./drm/nova/       (Nova DRM frontend)
#   ./drm/ttm/        (Nouveau memory manager dependency)
#   ./drm/scheduler/  (GPU scheduler used by modern DRM drivers)
#   ./drm/display/    (shared DP/display helpers; kept conservatively)
#   ./drm/clients/    (small shared DRM clients; kept conservatively)
#
# Removed:
#   host1x, ipu-v3, GPU tests, and every unrelated first-level DRM driver
#   directory (i915, xe, Radeon, ARM SoC drivers, virtual GPUs, etc.).
#

set -eu

APPLY=0
KEEP_NOVA=1

usage()
{
    cat <<'EOF'
Usage:
  ./prune-nvidia-gpu.sh [--dry-run] [--apply] [--no-nova]

Options:
  --dry-run   Show what would be removed. This is the default.
  --apply     Actually delete the directories.
  --no-nova   Also remove nova-core and drm/nova; useful for a P4/Nouveau-only tree.
  -h, --help  Show this help.

Examples:
  ./prune-nvidia-gpu.sh
  ./prune-nvidia-gpu.sh --apply
  ./prune-nvidia-gpu.sh --apply --no-nova
EOF
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --dry-run)
            APPLY=0
            ;;
        --apply)
            APPLY=1
            ;;
        --no-nova)
            KEEP_NOVA=0
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage >&2
            exit 2
            ;;
    esac
    shift
done

# Safety checks: refuse to operate unless this really looks like drivers/gpu.
if [ ! -d drm ] || [ ! -f Kconfig ] || [ ! -f Makefile ]; then
    echo "ERROR: run this script from the Linux kernel drivers/gpu directory." >&2
    exit 1
fi

if [ ! -d drm/nouveau ]; then
    echo "ERROR: drm/nouveau was not found. Refusing to prune." >&2
    exit 1
fi

if [ "$KEEP_NOVA" -eq 1 ]; then
    if [ ! -d nova-core ] || [ ! -d drm/nova ]; then
        echo "WARNING: Nova was requested but nova-core and/or drm/nova is missing." >&2
        echo "         Nouveau will still be preserved." >&2
    fi
fi

before_kb=$(du -sk . 2>/dev/null | awk '{print $1}')
removed_count=0

remove_path()
{
    path=$1

    [ -e "$path" ] || return 0

    size_kb=$(du -sk "$path" 2>/dev/null | awk '{print $1}')
    [ -n "$size_kb" ] || size_kb=0

    if [ "$APPLY" -eq 1 ]; then
        printf 'DELETE  %8s KB  %s\n' "$size_kb" "$path"
        rm -rf -- "$path"
    else
        printf 'WOULD DELETE  %8s KB  %s\n' "$size_kb" "$path"
    fi

    removed_count=$((removed_count + 1))
}

echo "Pruning Linux drivers/gpu for NVIDIA Nouveau/NVK"
if [ "$KEEP_NOVA" -eq 1 ]; then
    echo "Nova mode: KEEP nova-core + drm/nova"
else
    echo "Nova mode: REMOVE nova-core + drm/nova"
fi

if [ "$APPLY" -eq 1 ]; then
    echo "Mode: APPLY (deletions are real)"
else
    echo "Mode: DRY RUN (nothing will be deleted)"
fi
echo

#
# Top-level GPU directories unrelated to discrete NVIDIA PCIe support.
# Keep vga/ and trace/ because they are small and can be referenced by
# common/Nouveau configurations.
#
remove_path host1x
remove_path ipu-v3
remove_path tests

if [ "$KEEP_NOVA" -eq 0 ]; then
    remove_path nova-core
fi

#
# Keep only NVIDIA drivers and the shared DRM support most likely to be
# useful for Nouveau/NVK or Nova.
#
for path in drm/*; do
    [ -d "$path" ] || continue

    name=${path#drm/}

    case "$name" in
        nouveau|ttm|scheduler|display|clients)
            # Keep.
            ;;
        nova)
            if [ "$KEEP_NOVA" -eq 0 ]; then
                remove_path "$path"
            fi
            ;;
        *)
            remove_path "$path"
            ;;
    esac
done

echo
if [ "$APPLY" -eq 1 ]; then
    after_kb=$(du -sk . 2>/dev/null | awk '{print $1}')
    saved_kb=$((before_kb - after_kb))

    echo "Done."
    printf 'Before:  %10s KB\n' "$before_kb"
    printf 'After:   %10s KB\n' "$after_kb"
    printf 'Removed: %10s KB\n' "$saved_kb"
    printf 'Deleted directory groups: %s\n' "$removed_count"
    echo
    echo "Remaining first-level directories:"
    find . -maxdepth 1 -mindepth 1 -type d -print | sort
    echo
    echo "Remaining DRM directories:"
    find drm -maxdepth 1 -mindepth 1 -type d -print | sort
else
    echo "Dry run complete. Re-run with --apply to perform the deletion."
fi
