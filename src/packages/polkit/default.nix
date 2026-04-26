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

  src = null;
  dontUnpack = true;

  installPhase = ''
    mkdir -p ${vars.systemd.path}
    mkdir -p ${vars.systemd.enabledPath}
    mkdir -p ${vars.dbus.path}

    cp -p ${polkitDbus}/* ${vars.dbus.path}

    cp ${polkit}/*.service ${vars.systemd.path}
    ln -s ${vars.systemd.path}/polkit.service ${vars.systemd.enabledPath}/polkit.service

  '';
}
