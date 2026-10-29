inputs@{
  pkgs,
  stdenv,
  name,
  repo,
  commit,
  file_types ? [ ],
  lspPackageName ? null,
  vars,
  ...
}:
let
  grammarRepo = fetchGit {
    name = "${name}-treesitter";
    url = repo;
    rev = commit;
  };
  queriesDir = ./queries;
  quote = s: "'${s}'";
  quoted_file_types = map quote file_types;
  separated_file_types = builtins.concatStringSep ", " quoted_file_types;
  register_string = "vim.treesitter.language.register(${quote name}, { ${separated_file_types} }))";
  file_type_string = if file_types == [ ] then "" else register_string;
  conf_dir = "${vars.config_dir}/nvim";
in
stdenv.mkDerivation {
  name = "tree-sitter-${name}";
  src = null;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $TMP/.tscache
    export XDG_CACHE_HOME=$TMP/.tscache

    mkdir -p ${conf_dir}/parser
    mkdir -p ${conf_dir}/queries

    if [ -n "$(ls -A ${queriesDir}/${name})" ]; then
        cp -r ${queriesDir}/${name} ${conf_dir}/queries/
    fi

    echo "${file_type_string}" > ${conf_dir}/register_${name}.lua

    cd ${grammarRepo}
    ${pkgs.tree-sitter}/bin/tree-sitter build -o ${conf_dir}/parser/${name}.so
  '';
}
