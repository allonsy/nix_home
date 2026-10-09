{
  stdenv,
  utils,
  vars,
  ...
}:
let
  env_file = utils.writeTemplate ./src/templates/environment {
    time_zone = vars.timeZone;
  };
in
stdenv.mkDerivation {
  name = "etc-setup";
  src = ./src;

  installPhase = ''
    # commands here
    mkdir -p $out/etc
    cp -r files/* $out/etc/
    cp ${env_file} $out/etc/environment
  '';
}
