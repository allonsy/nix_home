{
  pkgs,
  stdenv,
  kernelSources,
  ...
}:
let
  srcDir = "~/nix/src/packages/kernel/linux/src";
  kBuildEnv = stdenv.mkDerivation {
    name = "kbuild-env";
    src = null;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin

      cat << EOF > $out/bin/runner.sh
      #!/bin/bash

      export PATH=\$PATH:${pkgs.gnumake}/bin:${pkgs.gcc}/bin:${pkgs.flex}/bin:${pkgs.bison}/bin
      export C_INCLUDE_PATH=${pkgs.ncurses.dev}/include
      export LIBRARY_PATH=${pkgs.ncurses}/lib
      export NIX_LDFLAGS=-L${pkgs.ncurses}/lib

      TMPDIR=\$(mktemp -d)

      cd \$TMPDIR
      cp -r ${kernelSources.src}/* .
      cp ${srcDir}/config.ini .config
      chmod -R u+rw \$TMPDIR
      zsh
      echo "copying config back to repo"
      cp \$TMPDIR/.config ${srcDir}/config.ini
      cd ${srcDir}
      rm -rf \$TMPDIR
      EOF

      chmod +x $out/bin/runner.sh
    '';
  };
in
{
  type = "app";
  program = "${kBuildEnv}/bin/runner.sh";
}
