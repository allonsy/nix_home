{
  pkgs,
  stdenv,
  vars,
  ...
}:
let
  vendoredUVVersion = "0.13.4";
  macUV = fetchTarball {
    url = "https://github.com/astral-sh/uv/releases/download/${vendoredUVVersion}/uv-aarch64-apple-darwin.tar.gz";
    sha256 = "sha256:1pxmd6qmzcfv2nii9qj8kcn9whyh30631yahvbqjcxr6jpakxgjm";
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
