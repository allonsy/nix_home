{
  hostnameFlake,
  ...
}:
let
  hostname = import hostnameFlake;
in
{
  hostname = hostname;
  isLinux = hostname != "macos";
  isMacos = hostname == "macos";
  isNyx = hostname == "nyx";
}
