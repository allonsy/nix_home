{
  pkgs,
  stdenv,
  vars,
  utils,
  ...
}:
let
  wrappedKitty = utils.wrapGL pkgs pkgs.kitty [ "kitty" ] { extraBins = [ "kitten" ]; };
  isNyx = vars.hostname == "nyx";
  kitty = if vars.isLinux && !isNyx then wrappedKitty else pkgs.kitty;
in
stdenv.mkDerivation {
  name = "kitty";
  src = ./.;

  installPhase = ''
    mkdir -p $out/etc/config/kitty
    mkdir -p $out/bin

    cp ${kitty}/bin/kitty $out/bin/kitty
    cp ${kitty}/bin/kitten $out/bin/kitten

    cp kitty.conf $out/etc/config/kitty
    cp current-theme.conf $out/etc/config/kitty/current-theme.conf
  '';
}
