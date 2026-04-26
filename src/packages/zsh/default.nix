{
  pkgs,
  stdenv,
  vars,
  ...
}:
let
  isNyx = vars.hostname == "nyx";
  starship = "${pkgs.starship}/bin/starship";
  envVarFile = if isNyx then "env_vars.nyx.zsh" else "env_vars.${vars.hostname}.zsh";
  systemAliasFile = if isNyx then "aliases.nyx.zsh" else "aliases.${vars.hostname}.zsh";
in
stdenv.mkDerivation {
  name = "zsh";
  src = ./.;

  installPhase = ''
    # zsh
    mkdir -p $out/bin
    mkdir -p $out/etc/config/zsh
    mkdir -p $out/etc/config/starship

    cp zsh/aliases.zsh $out/etc/config/zsh
    cat zsh/${systemAliasFile} >> $out/etc/config/zsh/aliases.zsh

    cp zsh/env_vars.zsh $out/etc/config/zsh
    cat zsh/${envVarFile} >> $out/etc/config/zsh/env_vars.zsh

    cp zsh/zshrc $out/etc/config/zsh/zshrc
    cp zsh/zprofile $out/etc/config/zsh/zprofile

    cp ${pkgs.zsh}/bin/zsh $out/bin/zsh
    cp ${pkgs.atuin}/bin/atuin $out/bin/atuin

    #starship
    cp ${starship} $out/bin/starship
    cp starship/starship.toml $out/etc/config/starship/config.toml
  '';
}
