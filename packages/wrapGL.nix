nixpkgs: package: binNames: { extraBins ? [] }:
  let
    egl_vendor_base = "export __EGL_VENDOR_LIBRARY_FILENAMES=${nixpkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json";
    sh = "${nixpkgs.bash}/bin/bash";

    wrapperScripts = map (binName: {
      name = binName;
      pathName = nixpkgs.writeText "wrapperGL-${binName}" ''
        #!${sh}
        ${egl_vendor_base}
        ${package}/bin/${binName} $@
      '';
    }) binNames;
    extraScripts = map (binName: {
      name=binName;
      pathName="${package}/bin/${binName}";
    }) extraBins;

    symLinks = map (pathName: "ln -s ${pathName.pathName} $out/bin/${pathName.name}") (wrapperScripts ++ extraScripts);
    symLinkCommands = nixpkgs.lib.strings.concatStringsSep "\n" symLinks;
  in
    nixpkgs.stdenv.mkDerivation {
      name = "wrapGL-${package.name}";

      unpackPhase = "true";

      installPhase = ''
        mkdir -p $out/bin
        ${symLinkCommands}

        chmod +x $out/bin/*
      '';
    }
