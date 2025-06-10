{
  description = "Dotfiles flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    (import ../systems.nix).forEachSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "home_dotfiles";
          version = "2";
          src = ./.;

          installPhase = ''
            mkdir -p $out/usr/config/zsh
            mkdir -p $out/usr/config/jj
            mkdir -p $out/usr/config/starship

            # zsh
            cp zsh/zshrc $out/usr/config/zsh
            cp zsh/zprofile $out/usr/config/zsh
            cp zsh/aliases.zsh $out/usr/config/zsh
            cp zsh/env_vars.zsh $out/usr/config/zsh
            cp zsh/starship.toml $out/usr/config/starship/config.toml

            # jujutsu
            cp jujutsu/config.toml $out/usr/config/jj/config.toml
          '';
        };
      }
    );
}
