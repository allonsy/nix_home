{
  pkgs,
  stdenv,
  isLinux,
  ...
}:
let
  vendoredUVVersion = "0.7.8";
  macUV = fetchTarball {
    url = "https://github.com/astral-sh/uv/releases/download/${vendoredUVVersion}/uv-aarch64-apple-darwin.tar.gz";
    sha256 = "sha256:0lr3mm4nx58hylwqspcg674xhwh9i48y3h5vaqs3qaj49fvwkj8v";
    name = "vendored-uv-${vendoredUVVersion}";
  };
  uv = if isLinux then "${pkgs.uv}/bin" else macUV;
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
