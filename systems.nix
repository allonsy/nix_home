{
  forEachSystem = builder: let
    systems = [
      "x86_64-linux"
    ];
    systemMapper = systemName: { packages.${systemName}.default = (builder systemName).packages.default; };
    aggregator = acc: newElem: acc // (systemMapper newElem);
  in
    builtins.foldl' aggregator {} systems
  ;
}
