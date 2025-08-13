rec {
  linux = "x86_64-linux";
  macos = "aarch64-darwin";
  allSystems = [
    linux
    macos
  ];

  forEachSystem = buildDef:
    let
      merger = acc: newSystem:
        let
          newPackage = buildDef newSystem;
        in
          acc // {
            ${newSystem}.default = newPackage;
          };
      systemPackages = builtins.foldl' merger {} allSystems;
    in {
      packages = systemPackages;
    };
}
