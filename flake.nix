{
  description = "Home declarative flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nvim.url = "./nvim";
  };

  outputs = { self, nixpkgs, nvim }:
    let
      forEachSystems = (import ./systems.nix).forEachSystem;
    in
      forEachSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          nvimConfig = nvim.build pkgs;
          dotfiles = (import ./dotfiles/dotfiles.nix) system pkgs;
          scripts = (import ./scripts) pkgs;
          vendored_uv = (import ./packages/vendor_uv.nix) system pkgs;
          macosPackages = (import ./packages/macos_base.nix) pkgs;
          linuxPackages = (import ./packages/linux_base.nix) pkgs;
          systemPackages = if system == (import ./systems.nix).macos then macosPackages else linuxPackages;
        in
          pkgs.buildEnv {
            name = "home";
            paths = with pkgs; [
              atuin
              dotfiles
              eza
              git
              jujutsu
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
            ] ++ systemPackages;
          }
      );
}
