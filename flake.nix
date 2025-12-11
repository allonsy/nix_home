{
  description = "home";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    jj.url = "./packages/jujutsu";
    kitty.url = "./packages/kitty";
    nix.url = "./packages/nix";
    nvim.url = "./packages/nvim";
    scripts.url = "./packages/scripts";
    uv = {
      url = "./packages/uv";
    };
    zsh.url = "./packages/zsh";
  };

  outputs = {
    self,
    nixpkgs,
    jj,
    kitty,
    nix,
    nvim,
    scripts,
    uv,
    zsh,
  }:
    let
      systems = import ./systems.nix;
      forEachSystems = systems.forEachSystem;
      macosSystem = systems.macos;
      linuxSystem = systems.linux;
    in
      forEachSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          identifier = if system == macosSystem then "macos" else "linux";
          basePackages = (import ./packages/packages.base.nix) pkgs;
          systemPackages = (import ./packages/packages.${identifier}.nix) pkgs;
          _jj = jj.package identifier pkgs;
          _kitty = kitty.package identifier pkgs;
          _nix = nix.package identifier pkgs;
          _nvim = nvim.package identifier pkgs;
          _scripts = scripts.package identifier pkgs;
          _uv = uv.package identifier pkgs;
          _zsh = zsh.package identifier pkgs;
        in
          pkgs.buildEnv {
            name = "home";
            paths = [
              _jj
              _kitty
              _nix
              _nvim
              _scripts
              _uv
              _zsh
            ] ++ basePackages ++ systemPackages;
          }
      );
}
