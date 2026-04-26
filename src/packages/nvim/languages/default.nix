inputs@{
  pkgs,
  stdenv,
  ...
}:
let
  rsync = "${pkgs.rsync}/bin/rsync";
  buildGrammar' = import ./buildGrammar.nix;
  buildGrammar = conf: buildGrammar' (inputs // conf);
  grammarConfigs = builtins.fromJSON (builtins.readFile ./languages.json);
  grammars = map buildGrammar grammarConfigs;
in
stdenv.mkDerivation {
  name = "nvim-languages";
  src = null;
  dontUnpack = true;

  languages = grammars;

  installPhase = ''
    shopt -s nullglob
    mkdir -p $out/bin
    mkdir -p $out/parser
    mkdir -p $out/queries
    mkdir -p $out/lsp

    touch $out/conf.lua
    for language in $languages; do
      cp -r $language/parser/* $out/parser/
      ${rsync} $language/queries/ $out/queries/
      cp -r $language/lsp/* $out/lsp
      cp $language/bin/* $out/bin
      cat $language/conf.lua >> $out/conf.lua
    done
  '';
}
