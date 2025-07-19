{
  description = "Home declarative flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nvim.url = "./nvim";
  };

  outputs = { self, nixpkgs, nvim }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      nvimConfig = nvim.build pkgs;
      dotfiles = (import ./dotfiles/dotfiles.nix) pkgs;
      scripts = (import ./scripts) pkgs;
      wrapGL = (import ./wrapGL.nix) pkgs;
    in {
      packages.${system}.default = pkgs.buildEnv {
            name = "home";
            paths = with pkgs; [
              atuin
              dotfiles
              calibre
              eza
              git
              jujutsu
              (wrapGL kitty [ "kitty" ] {extraBins=["kitten"];})
              neovim
              nvimConfig
              nix
              nodejs
              pnpm
              python3
              rustup
              scripts
              uv
              zsh

            ];
          };
    };
}
