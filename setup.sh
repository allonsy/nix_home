#!/bin/sh

# zsh
ln -sf ~/.nix-profile/usr/config/zsh/zshrc ~/.zshrc
ln -sf ~/.nix-profile/usr/config/zsh/zprofile ~/.zprofile

#jujutsu
mkdir -p ~/.config/jj
ln -sf ~/.nix-profile/usr/config/jj/config.toml ~/.config/jj/config.toml
