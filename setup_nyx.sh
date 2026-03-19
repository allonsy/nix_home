#!/usr/bin/env bash

mkdir -p ~/.config

# fonts
rm -rf ~/.config/fonts
ln -sf ~/.nix-profile/share/fonts ~/.config/fonts

# zsh
ln -sf ~/.nix-profile/usr/config/zsh/zshrc ~/.zshrc
ln -sf ~/.nix-profile/usr/config/zsh/zprofile ~/.zprofile
ln -sf ~/.nix-profile/usr/config/starship/config.toml ~/.config/starship.toml

# jujutsu
mkdir -p ~/.config/jj
ln -sf ~/.nix-profile/usr/config/jj/config.toml ~/.config/jj/config.toml

# waybar
rm -rf ~/.config/waybar
ln -sf ~/.nix-profile/usr/config/waybar ~/.config/waybar

#hyprland
rm -rf ~/.config/hypr
ln -sf ~/.nix-profile/usr/config/hypr ~/.config/hypr

# nix
mkdir -p ~/.config/nix
ln -sf ~/.nix-profile/usr/config/nix/nix.conf ~/.config/nix/nix.conf

# kitty
rm -rf ~/.config/kitty
ln -sf ~/.nix-profile/usr/config/kitty ~/.config/kitty

# nvim
rm -rf ~/.config/nvim
ln -sf ~/.nix-profile/usr/config/nvim ~/.config/nvim

# ssh
mkdir -p ~/.ssh
ln -sf ~/.nix-profile/usr/config/ssh/ssh_config ~/.ssh/config
