inputs@{
  stdenv,
  ...
}:
let
  pluginConfigurations = builtins.fromJSON (builtins.readFile ./plugins.json);
  pluginBuilderModule = import ./plugin.nix;
  pluginBuilder = conf: pluginBuilderModule (inputs // conf);
  plugins = map pluginBuilder pluginConfigurations;
in
stdenv.mkDerivation {
  name = "nvim-plugins";
  src = null;
  dontUnpack = true;

  plugins = plugins;

  installPhase = ''
    mkdir -p $out/plugins/start
    mkdir -p $out/plugins/opt

    for plugin in $plugins; do
      cp -r $plugin/plugins/* $out/plugins/
    done
  '';

}
