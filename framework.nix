{
  nixpkgs,
  packagesDir,
  system,
  hostname,
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
  rsync = "${pkgs.rsync}/bin/rsync";
  systemArguments = rec {
    inherit system;
    inherit hostname;
    isLinux = system == "x86_64-linux";
    isMacos = system == "aarch64-darwin";
    systemName = if isLinux then "linux" else "macos";
  };
  utils = import ./utils;

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
        rsync = rsync;
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
