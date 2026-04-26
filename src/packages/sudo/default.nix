{
  stdenv,
  pkgs,
  ...
}:
stdenv.mkDerivation {
  name = "sudo";
  src = null;
  dontUnpack = true;

  installPhase = ''
        # commands here
    	mkdir -p $out/setuid
    	mkdir -p $out/bin

    	cp ${pkgs.sudo}/bin/visudo $out/bin/visudo
    	cp ${pkgs.sudo}/bin/sudo $out/setuid/sudo

  '';
}
