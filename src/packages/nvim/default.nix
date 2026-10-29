inputs@{
  pkgs,
  stdenv,
  vars,
  ...
}:
let
  languages = (import ./languages) inputs;
  plugins = (import ./plugins) inputs;
  src_dir = ./src;
in
pkgs.symlinkJoin {
  name = "nvim";
  paths = [ languages ];

  postBuild = ''
    export NVIM_CONFIG_DIR=${vars.config_dir}/nvim
    mkdir -p $NVIM_CONFIG_DIR
    mkdir -p $NVIM_CONFIG_DIR/plugins/

    mkdir -p $out/bin

    cp -r ${src_dir}/* $NVIM_CONFIG_DIR

    cp ${pkgs.neovim}/bin/nvim $out/bin/nvim
    ln -s $out/bin/nvim $out/bin/vim

    cp -r ${plugins}/plugins/* $NVIM_CONFIG_DIR/plugins

  '';
}
