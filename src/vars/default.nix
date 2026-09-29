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
  systemd = {
    path = "$out/lib/systemd/user";
    systemPath = "lib/systemd/system";
    enabledPath = "$out/lib/systemd/user/multi-user.target.wants";
  };
  dbus = {
    path = "$out/share/dbus-1/system.d";
    relPath = "/share/dbus-1/system.d";
  };
  FRAMEWORK_BUILD_DIR = "/home/alecsnyder/nix";
  FRAMEWORK_PROFILE_DIR = "/system";
}
