{
  stdenv,
  ...
}:
stdenv.mkDerivation {
  name = "";
  src = ./src;

  # src = null;
  # dontUnpack = true;

  installPhase = ''
    # commands here
  '';
}
