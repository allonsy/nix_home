{
  description = "nvim";

  inputs = {
    commentary = {
      url = "github:tpope/vim-commentary";
      flake = false;
    };
    harpoon = {
      url = "github:theprimeagen/harpoon/harpoon2";
      flake = false;
    };
    lspConfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    telescope = {
      url = "github:nvim-telescope/telescope.nvim";
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
    harpoon,
    lspConfig,
    plenary,
    telescope,
    treeSitter,
  }:
    {
      package = system: pkgs:
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
          name = "nvim";
          src = ./src;

          installPhase = ''
            mkdir -p $out/usr/config/nvim
            mkdir -p $out/usr/config/nvim/plugins/start
            mkdir -p $out/usr/config/nvim/plugins/opt
            mkdir -p $out/bin

            cp -r * $out/usr/config/nvim/

            # plugins
            ln -s ${commentary} $out/usr/config/nvim/plugins/start/commentary
            ln -s ${harpoon} $out/usr/config/nvim/plugins/start/harpoon
            ln -s ${lspConfig} $out/usr/config/nvim/plugins/start/lspConfig
            ln -s ${plenary} $out/usr/config/nvim/plugins/start/plenary
            ln -s ${telescope} $out/usr/config/nvim/plugins/start/telescope
            ln -s ${treeSitter} $out/usr/config/nvim/plugins/start/treesitter

            ln -s ${builtLanguages}/languages $out/usr/config/nvim/
            cat ${builtLanguages}/conf.lua >> $out/usr/config/nvim/lua/lsp-conf.lua

            cp ${builtLanguages}/bin/* $out/bin
            cp ${pkgs.neovim}/bin/nvim $out/bin/nvim
          '';
        };
    };
}
