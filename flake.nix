{
  description = "Home declarative flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # custom subflakes
    dotfiles = {
      url = "path:./dotfiles";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, dotfiles }:
    let
      systems = import ./systems.nix;
    in
        systems.forEachSystem (system:
        let
            pkgs = import nixpkgs { inherit system; };
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

                    # custom packages
                    dotfiles.packages.${system}.default
                ];
            };
        }
        );
}
