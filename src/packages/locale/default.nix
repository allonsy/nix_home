{
  stdenv,
  pkgs,
  vars,
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
  tzLocation = "${pkgs.tzdata}/share/zoneinfo/${vars.timeZone}";
  localeConf = stdenv.mkDerivation {
    name = "locale-conf";
    src = null;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/etc/
      mkdir -p $out/share/zoneinfo/"$(dirname ${vars.timeZone})"


      ln -s ${tzLocation} $out/etc/localtime
      ln -s ${tzLocation} $out/share/zoneinfo/${vars.timeZone}

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
