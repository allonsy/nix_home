{
  stdenv,
  ...
}:
stdenv.mkDerivation {
  name = "etc-setup";
  src = ./src;

  installPhase = ''
    # commands here
    mkdir -p $out/etc
    cp -r * $out/etc/
  '';
}
