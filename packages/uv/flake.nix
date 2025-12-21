{
  description = "uv";

  inputs = {
    macUV = {
      url = "https://github.com/astral-sh/uv/releases/download/0.7.8/uv-aarch64-apple-darwin.tar.gz";
      flake = false;
    };
  };

  outputs =
    {
      self,
      macUV,
    }:
    {
      package =
        system: pkgs:
        let
          uv = if system.isLinux then "${pkgs.uv}/bin" else macUV;
        in
        pkgs.stdenv.mkDerivation {
          name = "uv";
          src = null;
          dontUnpack = true;

          installPhase = ''
            mkdir -p $out/bin
            cp ${uv}/uv $out/bin/
            cp ${uv}/uvx $out/bin/uvx
          '';
        };
    };
}
