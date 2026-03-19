{
  nixpkgs,
  system,
  isNyx ? false,
  inputs ? { },
  extras ? { },
  ...
}:
let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = pkgs.lib;
  systemArguments = rec {
    inherit system;
    inherit isNyx;
    isLinux = system == "x86_64-linux";
    isMacos = system == "aarch64-darwin";
    systemName = if isLinux then "linux" else "macos";
  };
  utils = import ./utils;

  packagesDir = ./packages;
  packageNames = builtins.attrNames (
    lib.filterAttrs (_name: type: type == "directory") (builtins.readDir packagesDir)
  );
  packages = lib.genAttrs packageNames (
    name:
    import (packagesDir + "/${name}") (
      {
        pkgs = pkgs;
        system = system;
        lib = lib;
        stdenv = pkgs.stdenv;
      }
      // utils
      // systemArguments
      // packages
      // inputs
      // extras
    )
  );
in
packages
