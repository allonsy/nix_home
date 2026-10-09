prefix: links:
let
  processLink = link: "[\"${prefix}${builtins.elemAt link 0}\", \"${builtins.elemAt link 1}\"],";
in
builtins.concatStringsSep "\n" (map processLink links)
