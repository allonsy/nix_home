{
  description = "uv";

  inputs = {
    macUV = {
      url = "";
      flake = false;
    };
  };

  outputs = {
    self,
    macUV,
  }:
    {
      package = system: pkgs:
      let
        uv = if system == "linux" then "${pkgs.uv}/bin" else macUV;
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
