{
  stdenv,
  ...
}:
stdenv.mkDerivation {
  name = "";
  src = ./.;

  installPhase = ''
    mkdir -p $out/usr/config/ssh

    cp config $out/usr/config/ssh/ssh_config
  '';
}
