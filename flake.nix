{
  description = "nix superflake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home.url = "./packages/home";
  };

  outputs =
    {
      self,
      nixpkgs,
      home,
    }:
    let
      systems = import ./systems.nix;
      linux = systems.linux;
      macos = systems.macos;
      nyx = systems.nyx;
    in
    {
      packages.${linux.system} =
        let
          pkgs = import nixpkgs {
            system = linux.system;
            config.allowUnfree = true;
          };
        in
        {
          home = home.package linux pkgs;
          nyx = { };
        };
      packages.${macos.system}.home =
        let
          pkgs = import nixpkgs {
            system = macos.system;
            config.allowUnfree = true;
          };
        in
        home.package macos pkgs;
    };
}
