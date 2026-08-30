#!/bin/sh
# Crude inventory of high-value Linux APIs referenced by the retained source.
set -eu
ROOT=${1:-upstream/gpu}
PATTERN='\b(pci_[A-Za-z0-9_]+|dma_[A-Za-z0-9_]+|request_irq|free_irq|ioread[0-9a-z_]*|iowrite[0-9a-z_]*|kmalloc|kzalloc|kcalloc|kfree|mutex_[A-Za-z0-9_]+|spin_[A-Za-z0-9_]+|schedule_work|queue_work|request_firmware|release_firmware|copy_to_user|copy_from_user|drm_[A-Za-z0-9_]+)\b'
find "$ROOT/drm/nouveau" "$ROOT/drm/ttm" "$ROOT/drm/scheduler" -type f \( -name '*.c' -o -name '*.h' \) -print0 2>/dev/null |
    xargs -0 grep -Eho "$PATTERN" 2>/dev/null |
    sort | uniq -c | sort -nr
