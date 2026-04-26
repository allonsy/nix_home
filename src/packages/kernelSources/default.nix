{
  lib,
  ...
}:
let
  version = "7.0.10";
  majorVersion = lib.versions.major version;
  kernelTarball = fetchTarball {
    name = "linux-${version}";
    url = "https://cdn.kernel.org/pub/linux/kernel/v${majorVersion}.x/linux-${version}.tar.xz";
    sha256 = "sha256:1ck1fyvr22221nj9rmyh52c8l74ykd86wjvxagfbp2cf3inzsl8c";
  };
in
{
  src = kernelTarball;
  version = version;
}
