{
  vars,
  ...
}:
let
  services = (import ./services.nix) {
    inherit vars;
  };
in
{
  wrapGL = (import ./wrapGL.nix);
  systemd_enable = services.system_enable;
  systemd_user_enable = services.user_enable;
}
