{
  pkgs,
  stdenv,
  vars,
  ...
}:
stdenv.mkDerivation {
  name = "zed";
  src = ./src;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib/zed
    mkdir -p $out/usr/config/zed

    ${
      if vars.isMacos then
        ""
      else
        ''
          cp ${pkgs.zed-editor}/bin/zeditor $out/bin
          cp ${pkgs.zed-editor}/libexec/zed-editor $out/lib/zed/zed-editor
        ''
    }
    cp -r * $out/usr/config/zed
  '';
}
