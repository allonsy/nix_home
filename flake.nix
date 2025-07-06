{
  description = "Home declarative flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      dotfiles = (import ./dotfiles/dotfiles.nix) pkgs;
      scripts = (import ./scripts) pkgs;
      wrapGL = (import ./wrapGL.nix) pkgs;
    in {
      packages.${system}.default = pkgs.buildEnv {
            name = "home";
            paths = with pkgs; [
              atuin
              dotfiles
              eza
              git
              jujutsu
              (wrapGL kitty [ "kitty" ] {extraBins=["kitten"];})
              neovim
              nix
              nodejs
              pnpm
              python3
              scripts
              uv
              zsh

            ];
          };
    };
}
