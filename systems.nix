rec {
  linuxSystemName = "x86_64-linux";
  forEachSystem = builder: let
    systems = [
      linuxSystemName
    ];
    systemMapper = systemName: { packages.${systemName}.default = (builder systemName).packages.default; };
    aggregator = acc: newElem: acc // (systemMapper newElem);
  in
    builtins.foldl' aggregator {} systems
  ;
}
