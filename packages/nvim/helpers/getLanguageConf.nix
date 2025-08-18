pkgs: ts: lang:
  let
    languageConfBuilder = import ./languageConf.nix;
    languageConf = languageConfBuilder { pkgs=pkgs; treeSitter=ts; language=lang; };
    confFile = builtins.readFile "${languageConf}/config.txt";
    confSplit = builtins.filter (line: line != "") (builtins.split "\n" confFile);
  in
    {
      repo = builtins.elemAt confSplit 0;
      revision = builtins.elemAt confSplit 2;
    }
