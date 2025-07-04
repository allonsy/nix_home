{
  description = "Home declarative flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = import ./systems.nix;
      dotfiles = (import ./dotfiles/dotfiles.nix);
      scripts = (import ./scripts);

      packageOutput = systems.forEachSystem (system:
        let
          pkgs = import nixpkgs { inherit system; };
          dotfilesPkg = dotfiles pkgs system;
          wrapGL = (import ./wrapGL.nix) pkgs system;
          scriptsPkg = scripts pkgs;
        in {
          packages.default = pkgs.buildEnv {
            name = "home";
            paths = with pkgs; [
              eza
              jujutsu
              nix
              uv
              zsh
              neovim
              atuin
              (wrapGL kitty [ "kitty" ] {extraBins=["kitten"];})

              # custom packages
              dotfilesPkg
              scriptsPkg
            ];
          };
        }
      );
    in
      packageOutput // {
        dotfiles=dotfiles;
        scripts=scripts;
      }
    ;
}
