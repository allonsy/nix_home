{
  pkgs,
  stdenv,
  system,
  systemName,
  isNyx,
  atuin,
  ...
}:
let
  starship = "${pkgs.starship}/bin/starship";
  atuinInput = (import atuin).packages.${system}.default;
  envVarFile = if isNyx then "env_vars.nyx.zsh" else "env_vars.${systemName}.zsh";
  systemAliasFile = if isNyx then "aliases.nyx.zsh" else "aliases.${systemName}.zsh";
in
stdenv.mkDerivation {
  name = "zsh";
  src = ./.;

  installPhase = ''
    # zsh
    mkdir -p $out/bin
    mkdir -p $out/usr/config/zsh
    mkdir -p $out/usr/config/starship

    cp zsh/aliases.zsh $out/usr/config/zsh
    cat zsh/${systemAliasFile} >> $out/usr/config/zsh/aliases.zsh

    cp zsh/env_vars.zsh $out/usr/config/zsh
    cat zsh/${envVarFile} >> $out/usr/config/zsh/env_vars.zsh

    cp zsh/zshrc $out/usr/config/zsh/zshrc
    cp zsh/zprofile $out/usr/config/zsh/zprofile

    cp ${pkgs.zsh}/bin/zsh $out/bin/zsh
    cp ${atuinInput}/bin/atuin $out/bin/atuin
    # once hex gets added to mainline
    # cp ${pkgs.atuin}/bin/atuin $out/bin/atuin

    #starship
    cp ${starship} $out/bin/starship
    cp starship/starship.toml $out/usr/config/starship/config.toml
  '';
}
