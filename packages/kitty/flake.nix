{
  description = "kitty";

  inputs = {
  };

  outputs =
    {
      self,
    }:
    {
      package =
        system: pkgs:
        let
          wrapGL = (import ../utils/wrapGL.nix) pkgs;
          wrappedKitty = wrapGL pkgs.kitty [ "kitty" ] { extraBins = [ "kitten" ]; };
          kitty = if system.isLinux then wrappedKitty else pkgs.kitty;
        in
        pkgs.stdenv.mkDerivation {
          name = "kitty";
          src = ./.;

          installPhase = ''
            mkdir -p $out/usr/config/kitty
            mkdir -p $out/bin

            cp ${kitty}/bin/kitty $out/bin/kitty
            cp ${kitty}/bin/kitten $out/bin/kitten

            cp kitty.conf $out/usr/config/kitty
            cp current-theme.conf $out/usr/config/kitty/current-theme.conf
          '';
        };
    };
}
