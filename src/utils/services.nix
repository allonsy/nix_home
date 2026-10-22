{
  vars,
}:
let

  linker =
    isUser: path:
    let
      # path is copied to the store as <hash>-<name>, so take the name from the source path
      name = baseNameOf path;
      servicePath = if isUser then vars.systemd.userPath else vars.systemd.systemPath;
      enabledPath = if isUser then vars.systemd.userEnabledPath else vars.systemd.systemEnabledPath;
    in
    ''
      mkdir -p ${servicePath}
      mkdir -p ${enabledPath}

      cp ${path} ${servicePath}/${name}
      ln -s ${servicePath}/${name} ${enabledPath}/
    '';
in
{
  system_enable = linker false;
  user_enable = linker true;
}
