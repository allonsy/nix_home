{
  package = nixpkgs: system:
    let
      egl_vendor_base = "export __EGL_VENDOR_LIBRARY_FILENAMES=${nixpkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json\n";
      egl_vendor = if system == (import ../systems.nix).linuxSystemName then egl_vendor_base else "";
    in
      nixpkgs.stdenv.mkDerivation {
        pname = "home_dotfiles";
        version = "2";
        src = ./.;

        installPhase = ''
          # zsh
          mkdir -p $out/usr/config/zsh
          mkdir -p $out/usr/config/starship
          cp zsh/* $out/usr/config/zsh
          echo -n "${egl_vendor}" >> $out/usr/config/zsh/env_vars.zsh
          cp zsh/starship.toml $out/usr/config/starship/config.toml

          # jujutsu
          mkdir -p $out/usr/config/jj
          cp jujutsu/config.toml $out/usr/config/jj/config.toml

          # nix
          mkdir -p $out/usr/config/nix
          cp nix/nix.conf $out/usr/config/nix

          # kitty
          mkdir -p $out/usr/config/kitty
          cp kitty/* $out/usr/config/kitty
        '';
      };
}
