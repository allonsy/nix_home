{
  stdenv,
  pkgs,
  kernelSources,
  ...
}:
let
in
stdenv.mkDerivation {
  name = "linux";
  src = ./src;

  buildInputs = with pkgs; [
    elfutils
    openssl
  ];

  nativeBuildInputs = with pkgs; [
    bc
    bison
    cpio
    flex
    gzip
    kmod
    perl
  ];

  buildPhase = ''
    export KCFLAGS="-mtune=skylake"

    mkdir -p build
    mkdir -p modules

    export MODULES_INSTALL_DIR="$PWD/modules"

    cp -r ${kernelSources.src}/* build
    chmod -R u+w build

    cp config.ini build/.config
    cd build
    env
    make -j16

    make INSTALL_MOD_PATH="$MODULES_INSTALL_DIR" INSTALL_MOD_STRIP=1 -j16 modules_install
    rm $MODULES_INSTALL_DIR/lib/modules/${kernelSources.version}/build

    cd ..
  '';

  installPhase = ''
    mkdir -p $out/kernel

    cp build/arch/x86/boot/bzImage $out/kernel/vmlinux
    ln -s ${kernelSources.src} $out/src
    cp -r modules $out/
  '';
}
