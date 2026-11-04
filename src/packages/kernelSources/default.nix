{
  lib,
  ...
}:
let
  version = "7.3.1";
  majorVersion = lib.versions.major version;
  fetchVersion = lib.removeSuffix ".0" version;
  kernelTarball = fetchTarball {
    name = "linux-${fetchVersion}";
    url = "https://cdn.kernel.org/pub/linux/kernel/v${majorVersion}.x/linux-${fetchVersion}.tar.xz";
    sha256 = "sha256:1qdp8xc80cyq0zfwxy8lr2j6d65i4nm0bk4yx28qqcm5l1nhq03x";
  };
in
{
  src = kernelTarball;
  inherit version;
}
