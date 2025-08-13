system: nixpkgs:
  let
    starship = "${nixpkgs.starship}/bin/starship";
    macosSystem = (import ../systems.nix).macos;
    envVarFile = if system == macosSystem then "env_vars.macos.zsh" else "env_vars.linux.zsh";
    email = if system == macosSystem then "alec.snyder@at-bay.com" else "linuxbash8@gmail.com";
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
        cat zsh/${envVarFile} >> $out/usr/config/zsh/env_vars.zsh

        #starship
        cp ${starship} $out/bin/starship
        cp starship/starship.toml $out/usr/config/starship/config.toml

        # jujutsu
        mkdir -p $out/usr/config/jj
        cat <<EOF > $out/usr/config/jj/config.toml
        [user]
        name = "Alec Snyder"
        email = "${email}"

        EOF
        cat jujutsu/config.toml >> $out/usr/config/jj/config.toml

        # nix
        mkdir -p $out/usr/config/nix
        cp nix/nix.conf $out/usr/config/nix

        # kitty
        mkdir -p $out/usr/config/kitty
        cp kitty/* $out/usr/config/kitty
      '';
    }
