{
  description = "Dotfiles flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        starshipBin = pkgs.starship;
        zshBin = pkgs.zsh;
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "home_dotfiles";
          version = "1";
          src = ./.;

          installPhase = ''
            mkdir -p $out/usr/config/zsh
            mkdir -p $out/usr/config/jj
            mkdir -p $out/bin

            # zsh
            cp zsh/zshrc $out/usr/config/zsh
            cp zsh/zprofile $out/usr/config/zsh
            cp zsh/aliases.zsh $out/usr/config/zsh
            cp zsh/env_vars.zsh $out/usr/config/zsh

            ln -s ${zshBin}/bin/zsh $out/bin/zsh
            ln -s ${starshipBin}/bin/starship $out/bin/starship

            # jujutsu
            cp jujutsu/config.toml $out/usr/config/jj/config.toml
          '';
        };
      }
    );
}
