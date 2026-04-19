{
  description = "nix superflake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    inputs@{
      nixpkgs,
      ...
    }:
    let
      framework = import ./framework.nix;
      macosPkgs = framework {
        inherit nixpkgs;
        inherit inputs;
        system = "aarch64-darwin";
        hostname = "macos";
      };
      linuxPkgs = framework {
        inherit nixpkgs;
        inherit inputs;
        system = "x86_64-linux";
        hostname = "linux";
      };
      nyxPkgs = framework {
        inherit nixpkgs;
        inherit inputs;
        system = "x86_64-linux";
        hostname = "nyx";
      };
    in
    {
      packages.x86_64-linux.nyx = nyxPkgs;
      packages.x86_64-linux.linux = linuxPkgs;
      packages.aarch64-darwin.macos = macosPkgs;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-tree;
    };
}
