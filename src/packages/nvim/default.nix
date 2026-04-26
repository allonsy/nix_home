inputs@{
  pkgs,
  stdenv,
  ...
}:
let
  rsync = "${pkgs.rsync}/bin/rsync";
  languages = (import ./languages) inputs;
  plugins = (import ./plugins) inputs;
in
stdenv.mkDerivation {
  name = "nvim";
  src = ./src;

  installPhase = ''
    export NVIM_CONFIG_DIR=$out/usr/config/nvim
    mkdir -p $NVIM_CONFIG_DIR
    mkdir -p $NVIM_CONFIG_DIR/parser/
    mkdir -p $NVIM_CONFIG_DIR/queries/
    mkdir -p $NVIM_CONFIG_DIR/plugins/
    mkdir -p $NVIM_CONFIG_DIR/lsp/

    mkdir -p $out/bin

    cp -r * $NVIM_CONFIG_DIR

    cp ${pkgs.neovim}/bin/nvim $out/bin/nvim

    cp -r ${languages}/parser/* $NVIM_CONFIG_DIR/parser
    ${rsync} ${languages}/queries/ $NVIM_CONFIG_DIR/queries
    cp ${languages}/lsp/* $NVIM_CONFIG_DIR/lsp
    cat ${languages}/conf.lua >> $NVIM_CONFIG_DIR/lua/lsp-conf.lua

    cp -r ${plugins}/plugins/* $NVIM_CONFIG_DIR/plugins

  '';
}
