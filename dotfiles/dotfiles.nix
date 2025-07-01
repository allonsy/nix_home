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
          cp zsh/* $out/usr/config/zsh
          cp zsh/starship.toml $out/usr/config/starship/config.toml
          echo "eval \"\$(${starship} init zsh)\"" >> $out/usr/config/zsh/zshrc

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
