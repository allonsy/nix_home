{
  description = "zsh";

  inputs = {
  };

  outputs =
    {
      self,
    }:
    {
      package =
        system: pkgs:
        let
          starship = "${pkgs.starship}/bin/starship";
          envVarFile = "env_vars.${system.name}.zsh";
        in
        pkgs.stdenv.mkDerivation {
          name = "zsh";
          src = ./.;

          installPhase = ''
            # zsh
            mkdir -p $out/bin
            mkdir -p $out/usr/config/zsh
            mkdir -p $out/usr/config/starship

            cp zsh/aliases.zsh $out/usr/config/zsh
            cp zsh/env_vars.zsh $out/usr/config/zsh
            cat zsh/${envVarFile} >> $out/usr/config/zsh/env_vars.zsh
            cp zsh/zshrc $out/usr/config/zsh/zshrc
            cp zsh/zprofile $out/usr/config/zsh/zprofile

            cp ${pkgs.zsh}/bin/zsh $out/bin/zsh
            cp ${pkgs.atuin}/bin/atuin $out/bin/atuin

            #starship
            cp ${starship} $out/bin/starship
            cp starship/starship.toml $out/usr/config/starship/config.toml
          '';
        };
    };
}
