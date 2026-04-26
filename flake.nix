{
  description = "nix superflake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    framework.url = "github:allonsy/flake-framework";
    delta.url = "github:zed-industries/delta-nix";
  };

  outputs =
    {
      framework,
      nixpkgs,
      delta,
      ...
    }:
    let
    in
    framework.mkFlake {
      nixpkgs = nixpkgs;
      frameworkDir = ./src;
      inputs = {
        delta = delta;
      };
    };
}
