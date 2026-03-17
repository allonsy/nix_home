{
  pkgs,
  stdenv,
  commentary,
  harpoon,
  lspConfig,
  plenary,
  telescope,
  treeSitter,
  ...
}:
let
  languages = [
    "lua"
    "rust"
    "python"
  ];
  languageBuilder = (import ./helpers/buildLanguages.nix) pkgs treeSitter;
  builtLanguages = languageBuilder languages;
  pluginDir = "$out/usr/config/nvim/plugins/start";
in
stdenv.mkDerivation {
  name = "nvim";
  src = ./src;

  installPhase = ''
    mkdir -p $out/usr/config/nvim
    mkdir -p ${pluginDir}
    mkdir -p $out/usr/config/nvim/plugins/opt
    mkdir -p $out/bin

    cp -r * $out/usr/config/nvim/

    # plugins
    ln -s ${commentary} ${pluginDir}/commentary
    ln -s ${harpoon} ${pluginDir}/harpoon
    ln -s ${lspConfig} ${pluginDir}/lspConfig
    ln -s ${plenary} ${pluginDir}/plenary
    ln -s ${telescope} ${pluginDir}/telescope
    ln -s ${treeSitter} ${pluginDir}/treesitter

    ln -s ${builtLanguages}/languages $out/usr/config/nvim/
    cat ${builtLanguages}/conf.lua >> $out/usr/config/nvim/lua/lsp-conf.lua

    cp ${builtLanguages}/bin/* $out/bin
    cp ${pkgs.neovim}/bin/nvim $out/bin/nvim
  '';
}
