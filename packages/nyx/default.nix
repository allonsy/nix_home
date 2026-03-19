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
    uv
    zed-editor
    zoom-us
  ];
in
pkgs.buildEnv {
  name = "nyx";
  paths = customPkgs ++ fontPkgs ++ mainPkgs;
}
