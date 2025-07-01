nixpkgs:
  let
    env = "${nixpkgs.coreutils}/bin/env";
    uv = "${nixpkgs.uv}/bin/uv";
  in
    nixpkgs.stdenv.mkDerivation {
      name = "scripts";
      src = ./.;

      installPhase = ''
        mkdir -p $out/bin

        # jj.gc
        echo "#!${env} -S ${uv} run --script" > $out/bin/jj.gc
        cat jj.gc.py >> $out/bin/jj.gc

        # general
        chmod +x $out/bin/*
      '';
    }
