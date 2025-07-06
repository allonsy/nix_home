{
  description = "Home declarative flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
      dotfiles = (import ./dotfiles/dotfiles.nix) pkgs;
      scripts = (import ./scripts) pkgs;
    in {
      packages.${system}.default = pkgs.buildEnv {
            name = "home";
            paths = with pkgs; [
              atuin
              dotfiles
              eza
              git
              jujutsu
              kitty
              neovim
              nix
              nodejs
              pnpm
              python3
              scripts
              uv
              zsh

              #macos packages
              awscli2
              k9s
              tfswitch
              tgswitch
            ];
          };
    };
}
