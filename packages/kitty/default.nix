{
  pkgs,
  wrapGL,
  stdenv,
  isLinux,
  hostname,
  ...
}:
let
  wrappedKitty = wrapGL pkgs pkgs.kitty [ "kitty" ] { extraBins = [ "kitten" ]; };
  isNyx = hostname == "nyx";
  kitty = if isLinux && !isNyx then wrappedKitty else pkgs.kitty;
in
stdenv.mkDerivation {
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
}
