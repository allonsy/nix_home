{
  description = "nix superflake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    atuin.url = "github:atuinsh/atuin";
    atuin.inputs.nixpkgs.follows = "nixpkgs";
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

  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    let
      framework = import ./framework.nix;
      macosPkgs = framework {
        inherit nixpkgs;
        inherit inputs;
        system = "aarch64-darwin";
      };
      linuxPkgs = framework {
        inherit nixpkgs;
        inherit inputs;
        system = "x86_64-linux";
      };
      nyxPkgs = framework {
        inherit nixpkgs;
        inherit inputs;
        system = "x86_64-linux";
        isNyx = true;
      };
    in
    {
      packages.x86_64-linux.home = linuxPkgs.home;
      packages.x86_64-linux.nyx = nyxPkgs.nyx;
      packages.aarch64-darwin.home = macosPkgs.home;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-tree;
    };
}
