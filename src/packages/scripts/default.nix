{
  pkgs,
  stdenv,
  ...
}:
stdenv.mkDerivation {
  name = "scripts";
  src = ./src;

  buildInputs = [
    pkgs.uv
    pkgs.bash
  ];

  installPhase = ''
    patchShebangs .
    mkdir -p $out/bin

    # jj.gc
    cp jj.gc.py $out/bin/jj.gc

    # nenv
    cp nenv.sh $out/bin/nenv

    # nex
    cp nex.sh $out/bin/nex

    # general
    chmod +x $out/bin/*
  '';
}
