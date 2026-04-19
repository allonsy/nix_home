#!/usr/bin/env bash

set -e
cd $(dirname $0)
SYSTEM_DIR=/system

ensure_system_dir() {
    if [ ! -d "$SYSTEM_DIR" ]; then
        sudo mkdir -p "$SYSTEM_DIR"
    fi
}

cmd_upgrade() {
    ensure_system_dir
    echo "Building system..."
    nix build '.#nyx'
    local target
    target=$(readlink ./result)
    if [ -e "$SYSTEM_DIR/current" ]; then
        local timestamp
        timestamp=$(date '+%Y_%m_%d_%H_%M_%S')
        sudo mv "$SYSTEM_DIR/current" "$SYSTEM_DIR/${timestamp}"
    fi
    sudo ln -s "$target" "$SYSTEM_DIR/current"
}

cmd_downgrade() {
    ensure_system_dir
    local prev
    prev=$(find "$SYSTEM_DIR" -maxdepth 1 -type l ! -name current | sort | tail -1)
    if [ -z "$prev" ]; then
        echo "No previous versions found in $SYSTEM_DIR" >&2
        exit 1
    fi
    local target
    target=$(readlink "$prev")
    sudo rm "$SYSTEM_DIR/current"
    sudo ln -s "$target" "$SYSTEM_DIR/current"
    sudo rm "$prev"
}

cmd_wipe() {
    ensure_system_dir
    find "$SYSTEM_DIR" -maxdepth 1 -type l ! -name current -print0 | xargs -0 sudo rm -f
}

case "${1:-}" in
    upgrade)    cmd_upgrade ;;
    downgrade)  cmd_downgrade ;;
    wipe)       cmd_wipe ;;
    *)        echo "Usage: $0 {upgrade|downgrade|wipe}" >&2; exit 1 ;;
esac
