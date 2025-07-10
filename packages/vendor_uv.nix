pkgs:
let
    version = "0.7.8";
    source = builtins.fetchTarball {
        url = "https://github.com/astral-sh/uv/releases/download/${version}/uv-aarch64-apple-darwin.tar.gz";
        sha256 = "sha256:0lr3mm4nx58hylwqspcg674xhwh9i48y3h5vaqs3qaj49fvwkj8v";
    };
in
    pkgs.stdenv.mkDerivation {
        name = "uv";
        src = null;
        dontUnpack = true;

        installPhase = ''
        mkdir -p $out/bin

        ln -s ${source}/uv $out/bin/
        ln -s ${source}/uvx $out/bin/
        '';
    }
