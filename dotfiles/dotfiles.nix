{
  package = nixpkgs:
    let
      starship = "${nixpkgs.starship}/bin/starship";
    in
      nixpkgs.stdenv.mkDerivation {
        pname = "home_dotfiles";
        version = "2";
        src = ./.;

        installPhase = ''
          # zsh
          mkdir -p $out/usr/config/zsh
          mkdir -p $out/usr/config/starship
          cp zsh/{zshrc,zprofile} $out/usr/config/zsh
          echo "source ${./zsh/aliases.zsh}" >> $out/usr/config/zsh/zshrc
          echo "eval \"\$(${starship} init zsh)\"" >> $out/usr/config/zsh/zshrc
          echo "source ${./zsh/env_vars.zsh}" >> $out/usr/config/zsh/zprofile

          #starship
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
      };
}
