{
  pkgs,
  stdenv,
  vars,
  ...
}:
let
  vendoredUVVersion = "0.10.12";
  macUV = fetchTarball {
    url = "https://github.com/astral-sh/uv/releases/download/${vendoredUVVersion}/uv-aarch64-apple-darwin.tar.gz";
    sha256 = "sha256:0rw271h0laqnsykxzjbc72xc12vgb4hvdny83n811g141wq45h0l";
    name = "vendored-uv-${vendoredUVVersion}";
  };
  uv = if vars.isLinux then "${pkgs.uv}/bin" else macUV;
in
stdenv.mkDerivation {
  name = "uv";
  src = null;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp ${uv}/uv $out/bin/
    cp ${uv}/uvx $out/bin/uvx
  '';
}
