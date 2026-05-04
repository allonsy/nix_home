#!/bin/bash

set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <package>"
    exit 1
fi

STORE_DIR=$(nix build --print-out-paths --no-link "nixpkgs#$1")

cd "$STORE_DIR"

$SHELL
