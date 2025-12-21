{
  description = "home flake";

  inputs = {
    jj.url = "../jujutsu";
    kitty.url = "../kitty";
    nix.url = "../nix";
    nvim.url = "../nvim";
    scripts.url = "../scripts";
    uv = {
      url = "../uv";
    };
    zsh.url = "../zsh";
  };

  outputs =
    {
      self,
      jj,
      kitty,
      nix,
      nvim,
      scripts,
      uv,
      zsh,
    }:
    {
      package =
        system: pkgs:
        let
          identifier = if system.isMacos then "macos" else "linux";
          basePackages = (import ./packages.base.nix) pkgs;
          systemPackages = (import ./packages.${identifier}.nix) pkgs;
          _jj = jj.package system pkgs;
          _kitty = kitty.package system pkgs;
          _nix = nix.package system pkgs;
          _nvim = nvim.package system pkgs;
          _scripts = scripts.package system pkgs;
          _uv = uv.package system pkgs;
          _zsh = zsh.package system pkgs;
        in
        pkgs.buildEnv {
          name = "home flake";
          version = "1.0";
          paths = [
            _jj
            _kitty
            _nix
            _nvim
            _scripts
            _uv
            _zsh
          ]
          ++ basePackages
          ++ systemPackages;
        };
    };
}
