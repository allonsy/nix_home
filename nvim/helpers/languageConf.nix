{
  pkgs,
  treeSitter,
  language,
}:
  let
    lua = pkgs.lua;
  in
    pkgs.stdenv.mkDerivation {
      name = "treeSitter-${language}";
      src = ./handler.lua;

      unpackPhase = "true";

      installPhase = ''
        cp ${treeSitter}/lua/nvim-treesitter/parsers.lua parsers.lua
        mkdir $out
        ${lua}/bin/lua $src ${language} > $out/config.txt
      '';
    }
