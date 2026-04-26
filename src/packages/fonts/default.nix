{
  pkgs,
  stdenv,
  ...
}:
let
  fontConfig = stdenv.mkDerivation {
    name = "font-config-files";
    src = ./src;

    # src = null;
    # dontUnpack = true;

    installPhase = ''
      # commands here
      mkdir -p $out/etc/fonts
      cp fonts.conf $out/etc/fonts/
    '';
  };
in
pkgs.buildEnv {
  name = "font-config";

  paths = [
    fontConfig
    pkgs.fontconfig
    pkgs.dejavu_fonts
  ];
}
