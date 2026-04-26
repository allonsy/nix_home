inputs@{
  stdenv,
  pkgs,
  ...
}:
let
  initramfs = (import ./initramfs) inputs;
  linux = (import ./linux) inputs;
  firmware = (import ./firmware) inputs;
in
stdenv.mkDerivation {
  name = "kernel-system";
  src = null;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/boot
    mkdir -p $out/lib

    export INITRAMFS=$out/boot/initramfs.img

    cat ${pkgs.microcode-intel}/intel-ucode.img > $INITRAMFS
    cat ${initramfs}/initramfs.img >> $INITRAMFS

    cp ${linux}/kernel/vmlinux $out/boot

    cp -d ${linux}/src $out/boot/.src
    ln -s ${linux}/modules/lib/modules $out/lib/
    ln -s ${firmware}/lib/firmware $out/lib/
  '';
}
