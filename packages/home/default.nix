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
  _jj = jujutsu;
  _kitty = kitty;
  _nix = nix;
  _nvim = nvim;
  _scripts = scripts;
  _uv = uv;
  _zsh = zsh;
in
pkgs.buildEnv {
  name = "home flake";
  version = "1.0";
  paths = [
    _jj
    _kitty
    _nix
    _nvim
    _scripts
    _uv
    _zsh
  ]
  ++ basePackages
  ++ systemPackages;
}
