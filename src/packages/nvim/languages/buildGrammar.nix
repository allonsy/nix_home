inputs@{
  pkgs,
  stdenv,
  name,
  repo,
  commit,
  lspPackageName ? null,
  ...
}:
let
  grammarRepo = fetchGit {
    name = "${name}-treesitter";
    url = repo;
    rev = commit;
  };
  lspConfig = if lspPackageName != null then (import ./lspConf.nix) inputs else "";
in
stdenv.mkDerivation {
  name = "tree-sitter-${name}";
  src = null;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $TMP/.cache
    export XDG_CACHE_HOME=$TMP/.cache

    mkdir -p $out/bin
    mkdir -p $out/parser
    mkdir -p $out/queries
    mkdir -p $out/lsp

    cd ${grammarRepo}
    ${pkgs.tree-sitter}/bin/tree-sitter build -o $out/parser/${name}.so

    cat << EOF >> $out/lsp/${name}.lua
    -- LSP configuration for ${name}
    ${lspConfig}

    EOF

    echo "vim.lsp.enable('${name}')" >> $out/conf.lua

    ${if lspPackageName != null then "cp -r ${pkgs.${lspPackageName}}/bin/* $out/bin/" else ""}
  '';
}
