{
  lib,
  ...
}:
let
  version = "7.2.9";
  majorVersion = lib.versions.major version;
  kernelTarball = fetchTarball {
    name = "linux-${version}";
    url = "https://cdn.kernel.org/pub/linux/kernel/v${majorVersion}.x/linux-${version}.tar.xz";
    sha256 = "sha256:0hkl7wi6qk2asp00xp2kz72vhqcq7kvmyvbbgjl4i6rkqkwdwqwd";
  };
in
{
  src = kernelTarball;
  version = version;
}
