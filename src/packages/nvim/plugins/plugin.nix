{
  stdenv,
  name,
  repo,
  commit,
  lazy ? false,
  ...
}:
let
  pluginRepo = fetchGit {
    name = "nvim-plugin-${name}";
    url = repo;
    rev = commit;
  };
in
stdenv.mkDerivation {
  name = "nvim-plugin-${name}";
  src = null;
  dontUnpack = true;

  installPhase = ''
    export PLUGIN_DIR="$out/plugins/${if lazy then "opt" else "start"}"
    mkdir -p $PLUGIN_DIR

    cp -r ${pluginRepo} $PLUGIN_DIR/${name}
  '';
}
