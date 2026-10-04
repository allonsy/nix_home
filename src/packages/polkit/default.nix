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
    mkdir -p ${vars.systemd.systemPath}
    mkdir -p ${vars.systemd.systemEnabledPath}
    mkdir -p ${vars.dbus.path}
    mkdir -p $out/bin
    mkdir -p $out/etc/polkit-1/rules.d

    cp -r *.rules $out/etc/polkit-1/rules.d
    cp -r ${pkgs.polkit}/bin/* $out/bin

    cp -p ${polkitDbus}/* ${vars.dbus.path}

    cp services/* ${vars.systemd.systemPath}
    ln -s ${vars.systemd.systemPath}/polkit.service ${vars.systemd.systemEnabledPath}/
    ln -s ${vars.systemd.systemPath}/polkit-agent-helper.socket ${vars.systemd.systemEnabledPath}/

  '';
}
