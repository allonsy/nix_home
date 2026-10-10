{
  pkgs,
  stdenv,
  vars,
  ...
}:
stdenv.mkDerivation {
  name = "nix";
  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out${vars.config_dir}/nix

    cp ${pkgs.nix}/bin/nix $out/bin/nix
    cp nix.conf $out/${vars.config_dir}/nix
  '';
}
