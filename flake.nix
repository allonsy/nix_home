{
  description = "Home declarative flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";


    # custom subflakes
    dotfiles = {
      url = "path:./dotfiles";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

  };

  outputs = { self, nixpkgs, flake-utils, dotfiles }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

      in {
        packages.default = pkgs.buildEnv {
            name = "home";
            version = "1";
            paths = with pkgs; [
                eza
                jujutsu
                nix
                uv

                # custom packages
                dotfiles.packages.${system}.default
            ];
        };
      }
    );
}
