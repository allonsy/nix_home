{
  pkgs,
  hyprland,
  jujutsu,
  zsh,
  nix,
  kitty,
  scripts,
  nvim,
  ssh,
  zed,
  ...
}:
let
  customPkgs = [
    hyprland
    jujutsu
    kitty
    nix
    nvim
    ssh
    scripts
    zed
    zsh
  ];

  fontPkgs = with pkgs; [
    dejavu_fonts
    noto-fonts-color-emoji
  ];

  mainPkgs = with pkgs; [
    alsa-utils
    bat
    eza
    firefox
    fontconfig
    git
    google-chrome
    nixd
    openssh
    rofi
    rustup
    signal-desktop
    uv
    zoom-us
  ];
in
pkgs.buildEnv {
  name = "nyx";
  paths = customPkgs ++ fontPkgs ++ mainPkgs;
}
