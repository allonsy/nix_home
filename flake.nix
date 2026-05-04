{
  description = "nix superflake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    framework.url = "github:allonsy/flake-framework";
    hostnameFlake = {
      url = "path:/nix/host.nix";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      framework,
      hostnameFlake,
      ...
    }:
    framework.mkFlake {
      nixpkgs = nixpkgs;
      frameworkDir = ./src;
      inputs = {
        hostnameFlake = hostnameFlake;
      };
    };
}
