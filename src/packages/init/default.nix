{
  pkgs,
  stdenv,
  ...
}:
stdenv.mkDerivation {
  name = "systemd-init";
  src = ./src;

  installPhase = ''
    # commands here
    mkdir -p $out/bin
    mkdir -p $out/setuid
    mkdir -p $out/etc/
    cp ${pkgs.systemd}/bin/init $out/bin/init
    cp ${pkgs.util-linux}/bin/agetty $out/bin
    cp ${pkgs.linux-pam}/bin/unix_chkpwd $out/setuid
    cp bless_suid.sh $out/bin
    cp hostname $out/etc/hostname

    mkdir -p $out/lib
    cp -r ${pkgs.glibc}/lib/* $out/lib

    mkdir -p $out/etc/
    cp -r pam $out/etc/pam.d

    mkdir -p $out/lib/systemd/system
    cp -r ${pkgs.systemd}/example/systemd/system/* $out/lib/systemd/system
    rm -f $out/lib/systemd/system/default.target
    rm -f $out/lib/systemd/system/modprobe@.service

    mkdir -p $out/lib/systemd/user
    mkdir -p $out/lib/systemd/user/multi-user.target.wants
    mkdir -p $out/lib/systemd/user/local-fs.target.wants
    mkdir -p $out/lib/systemd/user/network.target.wants
    mkdir -p $out/lib/systemd/user/sysinit.target.wants

    ln -s $out/lib/systemd/system/systemd-remount-fs.service $out/lib/systemd/user/local-fs.target.wants/
    ln -s $out/lib/systemd/system/getty@.service $out/lib/systemd/user/multi-user.target.wants/getty@tty1.service

    cp services/* $out/lib/systemd/user

    ln -s $out/lib/systemd/user/modprobe@.service $out/lib/systemd/user/sysinit.target.wants/modprobe@amdgpu.service
    ln -s $out/lib/systemd/user/modprobe@.service $out/lib/systemd/user/sysinit.target.wants/modprobe@iwlmvm.service

    ln -s $out/lib/systemd/user/wpa_supplicant@.service $out/lib/systemd/user/network.target.wants/wpa_supplicant@wlo1.service
    ln -s $out/lib/systemd/user/dhcpcd@.service $out/lib/systemd/user/network.target.wants/dhcpcd@wlo1.service
    ln -s $out/lib/systemd/user/nixd.service $out/lib/systemd/user/multi-user.target.wants/
    ln -s $out/lib/systemd/user/seatd.service $out/lib/systemd/user/multi-user.target.wants/
    ln -s $out/lib/systemd/user/bless-suid.service $out/lib/systemd/user/local-fs.target.wants/

  '';
}
