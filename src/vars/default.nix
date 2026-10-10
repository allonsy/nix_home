{
  system,
  ...
}:
let
  username = "alecsnyder";
  home_dir = "/home/${username}";
  hostname = if system == "aarch64-darwin" then "macos" else "nyx";
in
{
  username = username;
  home_dir = home_dir;
  config_dir = "/etc/config";
  FRAMEWORK_BUILD_DIR = "${home_dir}/nix";
  FRAMEWORK_PROFILE_DIR = "/system";

  dbus = {
    path = "$out/share/dbus-1/system.d";
    relPath = "/share/dbus-1/system.d";
  };
  hostname = hostname;
  isLinux = hostname != "macos";
  isMacos = hostname == "macos";
  systemd = {
    systemPath = "$out/lib/systemd/system";
    userPath = "$out/lib/systemd/user";
    systemEnabledPath = "$out/lib/systemd/system/multi-user.target.wants";
    userEnabledPath = "$out/lib/systemd/user/basic.target.wants";
  };
  timeZone = "Asia/Tel_Aviv";
}
