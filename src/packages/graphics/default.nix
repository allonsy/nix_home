{
  pkgs,
  stdenv,
  utils,
  ...
}:
let
  open_gl_64 = pkgs.buildEnv {
    name = "open_gl_64";
    paths = [
      pkgs.mesa
      pkgs.libglvnd
    ];
  };
  open_gl_32 = pkgs.buildEnv {
    name = "open_gl_32";
    paths = [
      pkgs.pkgsi686Linux.mesa
      pkgs.pkgsi686Linux.libglvnd
    ];
  };
  graphics = stdenv.mkDerivation {
    name = "graphics";
    src = ./src;

    installPhase = ''
      mkdir -p $out/share/opengl-driver
      mkdir -p $out/share/opengl-driver-32

      cp -r ${open_gl_64}/* $out/share/opengl-driver
      cp -r ${open_gl_32}/* $out/share/opengl-driver-32

      ${utils.systemd_enable ./src/graphics.service}
    '';
  };
in
pkgs.buildEnv {
  name = "graphic_main";
  paths = [
    graphics
    open_gl_64
  ];
}
