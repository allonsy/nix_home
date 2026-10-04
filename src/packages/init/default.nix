{
  pkgs,
  stdenv,
  vars,
  ...
}:
let
in
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

    mkdir -p ${vars.systemd.systemPath}
    mkdir -p ${vars.systemd.userPath}

    cp -r ${pkgs.systemd}/example/systemd/system/* ${vars.systemd.systemPath}
    cp -r ${pkgs.systemd}/example/systemd/user/* ${vars.systemd.userPath}

    chmod -R +w ${vars.systemd.systemPath}
    chmod -R +w ${vars.systemd.userPath}

    rm -f ${vars.systemd.systemPath}/default.target
    rm -f ${vars.systemd.systemPath}/modprobe@.service

    mkdir -p ${vars.systemd.systemPath}/startup.target.wants
    mkdir -p ${vars.systemd.systemPath}/local-fs.target.wants
    mkdir -p ${vars.systemd.systemPath}/network.target.wants
    mkdir -p ${vars.systemd.systemPath}/sysinit.target.wants

    ln -s ${vars.systemd.systemPath}/systemd-remount-fs.service ${vars.systemd.systemPath}/local-fs.target.wants/
    ln -s ${vars.systemd.systemPath}/getty@.service ${vars.systemd.systemPath}/multi-user.target.wants/getty@tty1.service

    cp -r services/user/* $out/lib/systemd/user
    cp -r services/system/* $out/lib/systemd/system

    ln -s ${vars.systemd.systemPath}/modprobe@.service ${vars.systemd.systemPath}/sysinit.target.wants/modprobe@amdgpu.service
    ln -s ${vars.systemd.systemPath}/modprobe@.service ${vars.systemd.systemPath}/sysinit.target.wants/modprobe@iwlmvm.service

    ln -s ${vars.systemd.systemPath}/wpa_supplicant@.service ${vars.systemd.systemPath}/network.target.wants/wpa_supplicant@wlo1.service
    ln -s ${vars.systemd.systemPath}/dhcpcd@.service ${vars.systemd.systemPath}/network.target.wants/dhcpcd@wlo1.service
    ln -s ${vars.systemd.systemPath}/bless-suid.service ${vars.systemd.systemPath}/local-fs.target.wants/

  '';
}
