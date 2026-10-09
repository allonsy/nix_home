{
  system,
  ...
}:
let
  hostname = if system == "aarch64-darwin" then "macos" else "nyx";
in
{
  hostname = hostname;
  isLinux = hostname != "macos";
  isMacos = hostname == "macos";
  timeZone = "Asia/Tel_Aviv";
  systemd = {
    systemPath = "$out/lib/systemd/system";
    userPath = "$out/lib/systemd/user";
    systemEnabledPath = "$out/lib/systemd/system/multi-user.target.wants";
    userEnabledPath = "$out/lib/systemd/user/basic.target.wants";
  };
  dbus = {
    path = "$out/share/dbus-1/system.d";
    relPath = "/share/dbus-1/system.d";
  };
  FRAMEWORK_BUILD_DIR = "/home/alecsnyder/nix";
  FRAMEWORK_PROFILE_DIR = "/system";
}
