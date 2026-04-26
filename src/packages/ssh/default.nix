{
  stdenv,
  ...
}:
stdenv.mkDerivation {
  name = "ssh";
  src = ./.;

  installPhase = ''
    mkdir -p $out/etc/config/ssh

    cp config $out/etc/config/ssh/ssh_config
  '';
}
