#!/bin/sh

# zsh
ln -sf ~/.nix-profile/usr/config/zsh/zshrc ~/.zshrc
ln -sf ~/.nix-profile/usr/config/zsh/zprofile ~/.zprofile
mkdir -p ~/.config
ln -sf ~/.nix-profile/usr/config/starship/config.toml ~/.config/starship.toml

# jujutsu
mkdir -p ~/.config/jj
ln -sf ~/.nix-profile/usr/config/jj/config.toml ~/.config/jj/config.toml

# nix
mkdir -p ~/.config/nix
ln -sf ~/.nix-profile/usr/config/nix/nix.conf ~/.config/nix/nix.conf

# kitty
ln -sf ~/.nix-profile/usr/config/kitty ~/.config/
