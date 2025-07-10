{
  description = "nvim flake";

  inputs = {
    commentary = {
      url = "github:tpope/vim-commentary";
      flake = false;
    };
    treeSitter = {
      url = "github:nvim-treesitter/nvim-treesitter/main";
      flake = false;
    };
  };

  outputs = {
    self,
    commentary,
    treeSitter,
  }:
    {
      build = pkgs:
      let
        languages = [
          "lua"
          "rust"
          "python"
        ];
        languageBuilder = (import ./helpers/buildLanguages.nix) pkgs treeSitter;
        builtLanguages = languageBuilder languages;
      in
        pkgs.stdenv.mkDerivation {
          name = "neovim config";
          src = ./src;

          installPhase = ''
            mkdir -p $out/usr/config/nvim
            mkdir -p $out/usr/config/nvim/plugins/start
            mkdir -p $out/usr/config/nvim/plugins/opt

            cp -r * $out/usr/config/nvim/

            # plugins
            ln -s ${commentary} $out/usr/config/nvim/plugins/start/commentary
            ln -s ${treeSitter} $out/usr/config/nvim/plugins/start/treesitter

            ln -s ${builtLanguages}/languages $out/usr/config/nvim/
          '';
        };
    };
}
