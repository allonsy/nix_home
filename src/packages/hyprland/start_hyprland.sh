#!/usr/bin/env zsh

export GBM_BACKENDS_PATH=${pkgs.mesa}/lib/gbm
export LIBGL_DRIVERS_PATH=${pkgs.mesa}/lib/dri
export LIBVA_DRIVERS_PATH=${pkgs.mesa}/lib/dri:${pkgs.intel-media-driver}/lib/dri
export __EGL_VENDOR_LIBRARY_FILENAMES=${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json
export LD_LIBRARY_PATH=${pkgs.mesa}/lib:${pkgs.libvdpau-va-gl}/lib/vdpau:${pkgs.libglvnd}/lib

cd ~
nixGLIntel start-hyprland --no-nixgl --path ~/.nix-profile/bin/hyprland
