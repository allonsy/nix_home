{
  lib,
  ...
}:
let
  version = "7.3.0";
  majorVersion = lib.versions.major version;
  fetchVersion = lib.removeSuffix ".0" version;
  kernelTarball = fetchTarball {
    name = "linux-${fetchVersion}";
    url = "https://cdn.kernel.org/pub/linux/kernel/v${majorVersion}.x/linux-${fetchVersion}.tar.xz";
    sha256 = "sha256:16gm6mzmyv8iq2zg0zkdlwp4q32imk3g49q2j6rmqywa0lq05bvi";
  };
in
{
  src = kernelTarball;
  inherit version;
}
