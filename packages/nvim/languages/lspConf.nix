{
  pkgs,
  lib,
  lspPackageName,
  cmd,
  filetypes ? [ ],
  rootMarkers ? [ ],
  ...
}:
let
  cmdLength = builtins.length cmd;
  binName = builtins.elemAt cmd 0;
  fullBinName = "${pkgs.${lspPackageName}}/bin/${binName}";
  fullCmd = [ fullBinName ] ++ (lib.sublist 1 cmdLength cmd);
  listToLuaList = list: "{ ${builtins.concatStringsSep ", " (map (item: "'${item}'") list)} }";
in
''
  return {
    cmd = ${listToLuaList fullCmd},
    filetypes = ${listToLuaList filetypes},
    root_markers = ${listToLuaList rootMarkers},
    settings = {},
  }

''
