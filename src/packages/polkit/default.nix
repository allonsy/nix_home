{
  stdenv,
  vars,
  pkgs,
  ...
}:
let
  polkit = "${pkgs.polkit.out}/${vars.systemd.systemPath}";
  polkitDbus = "${pkgs.polkit.out}/${vars.dbus.relPath}";
in
stdenv.mkDerivation {
  name = "polkit";
  src = ./src;

  installPhase = ''
    mkdir -p ${vars.systemd.path}
    mkdir -p ${vars.systemd.enabledPath}
    mkdir -p ${vars.dbus.path}
    mkdir -p $out/bin
    mkdir -p $out/etc/polkit-1/rules.d

    cp -r *.rules $out/etc/polkit-1/rules.d
    cp -r ${pkgs.polkit}/bin/* $out/bin

    cp -p ${polkitDbus}/* ${vars.dbus.path}

    cp ${polkit}/*.service ${vars.systemd.path}
    cp ${polkit}/*.socket ${vars.systemd.path}
    ln -s ${vars.systemd.path}/polkit.service ${vars.systemd.enabledPath}/polkit.service
    ln -s ${vars.systemd.path}/polkit-agent-helper.socket ${vars.systemd.enabledPath}/

  '';
}
