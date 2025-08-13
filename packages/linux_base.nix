pkgs:
  let
    wrapGL = (import ./wrapGL.nix) pkgs;
    wrappedKitty = wrapGL pkgs.kitty ["kitty"] {extraBins=["kitten"];};
  in
    with pkgs; [
      calibre
      wrappedKitty
    ]
