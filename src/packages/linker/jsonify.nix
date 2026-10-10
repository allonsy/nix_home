{
  prefix,
  links,
  lib,
  home_dir,
  ...
}:
let
  subHome = lib.strings.replaceString "@HOME@" home_dir;
  stringify = str: "\"${str}\"";
  normalizeSourcePath = str: "${prefix}${lib.removePrefix "/" str}";
  preProcess = link: [
    (stringify (normalizeSourcePath (builtins.elemAt link 0)))
    (stringify (subHome (builtins.elemAt link 1)))
  ];
  joinLocations = link: builtins.concatStringsSep ", " (preProcess link);
  processLink = link: "[ ${joinLocations link} ]";
  processedLinks = builtins.concatStringsSep "," (map processLink links);
in
"[" + processedLinks + "]"
