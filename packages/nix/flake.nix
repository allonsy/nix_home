{
  description = "nix";

  inputs = {
  };

  outputs =
    {
      self,
    }:
    {
      package =
        system: pkgs:
        pkgs.stdenv.mkDerivation {
          name = "nix";
          src = ./.;

          installPhase = ''
            mkdir -p $out/bin
            mkdir -p $out/usr/config/nix

            cp ${pkgs.nix}/bin/nix $out/bin/nix
            cp nix.conf $out/usr/config/nix
          '';
        };
    };
}
