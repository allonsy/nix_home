{
  description = "nix superflake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    atuin.url = "github:atuinsh/atuin";
    atuin.inputs.nixpkgs.follows = "nixpkgs";
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
      };
      linuxPkgs = framework {
        inherit nixpkgs;
        inherit inputs;
        system = "x86_64-linux";
      };
      nyxPkgs = framework {
        inherit nixpkgs;
        inherit inputs;
        system = "x86_64-linux";
        isNyx = true;
      };
    in
    {
      packages.x86_64-linux.home = linuxPkgs.home;
      packages.x86_64-linux.nyx = nyxPkgs.nyx;
      packages.aarch64-darwin.home = macosPkgs.home;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-tree;
    };
}
