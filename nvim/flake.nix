{
  description = "nvim flake";

  inputs = {
      commentary.url = "github:tpope/vim-commentary";
      commentary.flake = false;
  };

  outputs = {
      self,
      commentary
  }:
    let
    in
        {
            build = pkgs: pkgs.stdenv.mkDerivation {
                name = "neovim config";
                src = ./src;

                installPhase = ''
                    mkdir -p $out/usr/config/nvim
                    mkdir -p $out/usr/config/nvim/plugins/start
                    mkdir -p $out/usr/config/nvim/plugins/opt

                    cp -r * $out/usr/config/nvim/

                    # plugins
                    ln -s ${commentary} $out/usr/config/nvim/plugins/start/commentary
                '';
            };
        };
}
