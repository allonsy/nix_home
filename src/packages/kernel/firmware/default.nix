{
  stdenv,
  pkgs,
  ...
}:
stdenv.mkDerivation {
  name = "firmware";
  src = null;
  dontUnpack = true;

  nativeBuildInputs = with pkgs; [
    cpio
  ];

  installPhase = ''
    export FIRMWARE_DIR=$out/lib/firmware
    mkdir -p $FIRMWARE_DIR

    mkdir -p $FIRMWARE_DIR/amdgpu
    cp -r ${pkgs.linux-firmware}/lib/firmware/amdgpu/dimgrey_cavefish* $FIRMWARE_DIR/amdgpu
    cp -r ${pkgs.linux-firmware}/lib/firmware/amdgpu/beige_goby* $FIRMWARE_DIR/amdgpu

    cp -r ${pkgs.linux-firmware}/lib/firmware/intel/iwlwifi/iwlwifi-QuZ-a0-hr-b0-77.ucode $FIRMWARE_DIR

  '';
}
