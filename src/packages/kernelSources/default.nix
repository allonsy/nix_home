{
  lib,
  ...
}:
let
  version = "7.2.8";
  majorVersion = lib.versions.major version;
  kernelTarball = fetchTarball {
    name = "linux-${version}";
    url = "https://cdn.kernel.org/pub/linux/kernel/v${majorVersion}.x/linux-${version}.tar.xz";
    sha256 = "sha256:0ph52nj320l5z0dz4ql9ynagc0zk2ianvcwqp51j5mjynjdgk091";
  };
in
{
  src = kernelTarball;
  version = version;
}
