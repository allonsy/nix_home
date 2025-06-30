{
  description = "Home declarative flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = import ./systems.nix;
    in
      systems.forEachSystem (system:
        let
          pkgs = import nixpkgs { inherit system; };
          dotfiles = (import ./dotfiles/dotfiles.nix).package pkgs system;
        in {
          packages.default = pkgs.buildEnv {
            name = "home";
            version = "2";
            paths = with pkgs; [
              eza
              jujutsu
              nix
              starship
              uv
              zsh
              mesa
              kitty

              # custom packages
              dotfiles
            ];
          };
        }
      );
}
