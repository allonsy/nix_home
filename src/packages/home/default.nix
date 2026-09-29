{
  pkgs,
  jujutsu,
  kitty,
  nix,
  nvim,
  scripts,
  uv,
  zed,
  zsh,
  vars,
  ...
}:
let
  basePackages = (import ./packages.base.nix) pkgs;
  systemPackages = (import ./packages.${vars.hostname}.nix) pkgs;
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
    zed
    zsh
  ]
  ++ basePackages
  ++ systemPackages;
}
