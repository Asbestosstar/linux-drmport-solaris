#!/bin/sh
set -u

echo "System: $(uname -a)"
for c in gcc gmake make ar ld elfedit elfdump pkg-config meson ninja; do
    if command -v "$c" >/dev/null 2>&1; then
        printf '%-12s %s\n' "$c" "$(command -v "$c")"
    else
        printf '%-12s %s\n' "$c" MISSING
    fi
done
