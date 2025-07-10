{
  description = "Home declarative flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nvim.url = "./nvim";
  };

  outputs = { self, nixpkgs, nvim }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      nvimConfig = nvim.build pkgs;
      dotfiles = (import ./dotfiles/dotfiles.nix) pkgs;
      scripts = (import ./scripts) pkgs;
      vendored_uv = (import ./packages/vendor_uv.nix) pkgs;
    in {
      packages.${system}.default = pkgs.buildEnv {
            name = "home";
            paths = with pkgs; [
              atuin
              dotfiles
              eza
              git
              jujutsu
              kitty
              neovim
              nvimConfig
              nix
              nodejs
              pnpm
              python3
              rustup
              scripts
              vendored_uv
              zsh

              #macos packages
              awscli2
              dapr-cli
              k9s
              kubectl
              stow
              tfswitch
              tgswitch
            ];
          };
    };
}
