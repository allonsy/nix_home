{
  pkgs,
  stdenv,
  vars,
  ...
}:
stdenv.mkDerivation {
  name = "herdr";
  src = ./src;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/${vars.config_dir}/herdr

    cp ${pkgs.herdr}/bin/herdr $out/bin
    cp config.toml $out/${vars.config_dir}/herdr/config.toml

  '';
}
