{
  stdenv,
  pkgs,
  ...
}:
let
  locales = [
    "en_US.UTF-8/UTF-8"
    "he_IL.UTF-8/UTF-8"
  ];
  localePkg = pkgs.glibcLocales.override {
    allLocales = false;
    locales = locales;
  };
  localeConf = stdenv.mkDerivation {
    name = "locale-conf";
    src = null;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/etc/

      ln -s ${pkgs.tzdata}/share/zoneinfo/Asia/Tel_Aviv $out/etc/localtime

      echo "LANG=en_US.UTF-8" > $out/etc/locale.conf
    '';
  };
in
pkgs.buildEnv {
  name = "system-locale";
  paths = [
    localePkg
    localeConf
  ];
}
