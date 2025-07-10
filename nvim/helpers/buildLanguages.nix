pkgs: ts: languages:
let
  languageConfBuilder = (import ./getLanguageConf.nix) pkgs ts;

  languageCommandList = map (language:
    let
      languageConf = languageConfBuilder language;
      repo = "${languageConf.repo}.git";
      revision = languageConf.revision;
      languageRepo = builtins.fetchGit { name=language; url=languageConf.repo; rev=languageConf.revision; };
    in
    ''
      cd ${languageRepo}
      ${pkgs.tree-sitter}/bin/tree-sitter build -o $out/languages/parser/${language}.so
      ln -s ${ts}/runtime/queries/${language} $out/languages/queries/${language}
    '') languages;
  languageCommands = builtins.concatStringsSep "\n" languageCommandList;
in
  pkgs.stdenv.mkDerivation {
    name="nvim-languages";

    src=null;
    dontUnpack=true;

    installPhase = ''
      mkdir -p $TMP/.cache
      export XDG_CACHE_HOME=$TMP/.cache
      mkdir -p $out/languages
      mkdir -p $out/languages/parser
      mkdir -p $out/languages/parser-info
      mkdir -p $out/languages/queries

      ${languageCommands}
    '';
  }
