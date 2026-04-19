#!/bin/sh

set -euo pipefail

cd $(dirname "$0")

. ./setup_utils.sh

# zsh
link ~/.nix-profile/usr/config/zsh/zshrc ~/.zshrc
link ~/.nix-profile/usr/config/zsh/zprofile ~/.zprofile
link ~/.nix-profile/usr/config/starship/config.toml ~/.config/starship.toml

# jujutsu
link ~/.nix-profile/usr/config/jj/config.toml ~/.config/jj/config.toml

# nix
link ~/.nix-profile/usr/config/nix/nix.conf ~/.config/nix/nix.conf

# kitty
link ~/.nix-profile/usr/config/kitty ~/.config/kitty

# zed
link ~/.nix-profile/usr/config/zed/settings.json ~/.config/zed/settings.json
link ~/.nix-profile/usr/config/zed/keymap.json ~/.config/zed/keymap.json
link ~/.nix-profile/usr/config/zed/themes ~/.config/zed/themes
