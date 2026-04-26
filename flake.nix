{
  description = "nix superflake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    framework.url = "github:allonsy/flake-framework";
  };

  outputs =
    { framework, nixpkgs, ... }:
    let
    in
    framework.mkFlake {
      nixpkgs = nixpkgs;
      frameworkDir = ./src;
    };
}
