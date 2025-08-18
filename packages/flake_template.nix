{
  description = "";

  inputs = {
  };

  outputs = {
    self,
  }:
    {
      package = system: pkgs:
      let
      in
        pkgs.stdenv.mkDerivation {
          name = "";
          src = ./.;

          installPhase = ''
          '';
        };
    };
}
