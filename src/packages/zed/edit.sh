#!/usr/bin/env bash

set -euo pipefail
cd "$(dirname "$0")"

ACTION="${1:-}"

if [[ "$ACTION" != "lock" && "$ACTION" != "unlock" ]]; then
    echo "Usage: $(basename "$0") <lock|unlock>" >&2
    exit 1
fi

ZED_FILES=(
    ~/.config/zed/settings.json
    ~/.config/zed/keymap.json
)

if [[ "$ACTION" == "unlock" ]]; then
    for f in "${ZED_FILES[@]}"; do
        cat "$f" > "${f}.new"
        rm "$f"
        mv "${f}.new" "$f"
    done
elif [[ "$ACTION" == "lock" ]]; then
    for f in "${ZED_FILES[@]}"; do
        cat "$f" > "./src/$(basename "$f")"
    done
fi
