{
  stdenv,
  pkgs,
  ...
}:
stdenv.mkDerivation {
  name = "initramfs";
  src = ./src;
  busybox = pkgs.pkgsStatic.busybox;

  nativeBuildInputs = with pkgs; [
    cpio
    gzip
  ];

  installPhase = ''
    OLD_DIR=$PWD
    mkdir -p $out/initramfs

    mkdir -p build
    mkdir -p build/bin
    cp init.sh build/init

    cp $busybox/bin/busybox build/bin/busybox

    cd $OLD_DIR/build
    ./bin/busybox --install ./bin

    find . -print0 | cpio --owner=0 --null -ov --format=newc | gzip -9 > $out/initramfs.img

  '';
}
