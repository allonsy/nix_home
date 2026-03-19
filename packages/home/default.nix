{
  pkgs,
  jujutsu,
  kitty,
  nix,
  nvim,
  scripts,
  uv,
  zsh,
  systemName,
  ...
}:
let
  basePackages = (import ./packages.base.nix) pkgs;
  systemPackages = (import ./packages.${systemName}.nix) pkgs;
in
pkgs.buildEnv {
  name = "home flake";
  version = "1.0";
  paths = [
    jujutsu
    kitty
    nix
    nvim
    scripts
    uv
    zsh
  ]
  ++ basePackages
  ++ systemPackages;
}
