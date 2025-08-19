{
  description = "scripts";

  inputs = {
  };

  outputs = {
    self,
  }:
    {
      package = system: pkgs:
      let
      in
        pkgs.stdenv.mkDerivation {
          name = "scripts";
          src = ./.;

          installPhase = ''
            mkdir -p $out/bin

            # jj.gc
            echo "#!${pkgs.coreutils}/bin/env -S ${pkgs.uv}/bin/uv run --script" > $out/bin/jj.gc
            cat jj.gc.py >> $out/bin/jj.gc

            # general
            chmod +x $out/bin/*
          '';
        };
    };
}
