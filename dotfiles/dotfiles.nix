nixpkgs:
  let
    starship = "${nixpkgs.starship}/bin/starship";
  in
    nixpkgs.stdenv.mkDerivation {
      name = "home_dotfiles";
      src = ./.;

      installPhase = ''
        # zsh
        mkdir -p $out/bin
        mkdir -p $out/usr/config/zsh
        mkdir -p $out/usr/config/starship

        cp zsh/* $out/usr/config/zsh

        #starship
        cp ${starship} $out/bin/starship
        cp starship/starship.toml $out/usr/config/starship/config.toml

        # jujutsu
        mkdir -p $out/usr/config/jj
        cp jujutsu/config.toml $out/usr/config/jj/config.toml

        # nix
        mkdir -p $out/usr/config/nix
        cp nix/nix.conf $out/usr/config/nix

        # kitty
        mkdir -p $out/usr/config/kitty
        cp kitty/* $out/usr/config/kitty
      '';
    }
