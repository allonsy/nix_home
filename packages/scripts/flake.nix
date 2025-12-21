{
  description = "scripts";

  inputs = {
  };

  outputs =
    {
      self,
    }:
    {
      package =
        system: pkgs:
        pkgs.stdenv.mkDerivation {
          name = "scripts";
          src = ./.;

          installPhase = ''
            mkdir -p $out/bin

            # jj.gc
            echo "#!${pkgs.coreutils}/bin/env -S ${pkgs.uv}/bin/uv run --script" > $out/bin/jj.gc
            cat jj.gc.py >> $out/bin/jj.gc

            # nenv
            cp nenv.sh $out/bin/nenv

            # general
            chmod +x $out/bin/*
          '';
        };
    };
}
