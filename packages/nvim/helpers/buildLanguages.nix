pkgs: ts: languages:
let
  languageConfBuilder = (import ./getLanguageConf.nix) pkgs ts;
  languageLSPConfig = (import ./lsp.nix);

  languageCommandList = map (language:
    let
      languageConf = languageConfBuilder language;
      repo = "${languageConf.repo}.git";
      revision = languageConf.revision;
      languageRepo = builtins.fetchGit { name=language; url=languageConf.repo; rev=languageConf.revision; };
      lsp_config_line =
        if
          builtins.hasAttr language languageLSPConfig &&
          builtins.hasAttr "conf" languageLSPConfig.${language} &&
          languageLSPConfig.${language}.conf != null
        then "echo \"vim.lsp.enable('${languageLSPConfig.${language}.conf}')\" >> $out/conf.lua"
        else "";
      lsp_package_line =
        if
          builtins.hasAttr language languageLSPConfig &&
          builtins.hasAttr "pkg" languageLSPConfig.${language} &&
          languageLSPConfig.${language}.pkg != null
        then "cp ${pkgs.${languageLSPConfig.${language}.pkg}}/bin/${languageLSPConfig.${language}.pkg} $out/bin"
        else "";
    in
    ''
      cd ${languageRepo}
      ${pkgs.tree-sitter}/bin/tree-sitter build -o $out/languages/parser/${language}.so
      ln -s ${ts}/runtime/queries/${language} $out/languages/queries/${language}

      ${lsp_config_line}
      ${lsp_package_line}
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
      mkdir -p $out/bin

      mkdir -p $out/languages/parser
      mkdir -p $out/languages/parser-info
      mkdir -p $out/languages/queries

      ${languageCommands}
    '';
  }
