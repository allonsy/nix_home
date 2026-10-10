{
  pkgs,
  stdenv,
  lib,
  utils,
  vars,
  ...
}:
let
  prefix = "${vars.FRAMEWORK_PROFILE_DIR}/current/";
  python = "${pkgs.python3}/bin/python";
  linkerScript = utils.writeTemplate ./src/linker.py {
    new_symlink_file = new_symlink_file;
    old_symlink_file = "${vars.FRAMEWORK_PROFILE_DIR}/links/symlinks.json";
  };
  runner = utils.writeTemplate ./src/runner.sh {
    python = python;
    linker_file = linkerScript;
  };
  linkList = import ./links.nix;
  links = (import ./jsonify.nix) {
    prefix = prefix;
    links = linkList;
    lib = lib;
    home_dir = vars.home_dir;
  };
  new_symlink_file = utils.writeTemplate ./src/symlinks.json {
    links = links;
  };
in
stdenv.mkDerivation {
  name = "";
  src = ./src;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/etc/config/linker

    cp ${runner} $out/bin/nlink
    chmod +x $out/bin/nlink
    cp ${new_symlink_file} $out/etc/config/linker/new_symlinks.json

  '';
}
