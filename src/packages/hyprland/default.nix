{
  pkgs,
  stdenv,
  ...
}:
stdenv.mkDerivation {
  name = "hyprland";
  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/usr/config/hypr
    mkdir -p $out/usr/config/waybar

    cp ${pkgs.hyprland}/bin/hyprland $out/bin/
    cp ${pkgs.hyprland}/bin/hyprctl $out/bin/
    cp ${pkgs.xwayland}/bin/Xwayland $out/bin/
    cp ${pkgs.hyprland}/bin/start-hyprland $out/bin/
    cp ${pkgs.waybar}/bin/waybar $out/bin/
    cp ${pkgs.swaybg}/bin/swaybg $out/bin/

    cp start_hyprland.sh $out/bin/start_hyprland

    cat << EOF > $out/bin/start_hyprland
    #!/usr/bin/env zsh

    export GBM_BACKENDS_PATH=${pkgs.mesa}/lib/gbm
    export LIBGL_DRIVERS_PATH=${pkgs.mesa}/lib/dri
    export LIBVA_DRIVERS_PATH=${pkgs.mesa}/lib/dri:${pkgs.intel-media-driver}/lib/dri
    export __EGL_VENDOR_LIBRARY_FILENAMES=${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json
    export LD_LIBRARY_PATH=${pkgs.mesa}/lib:${pkgs.libvdpau-va-gl}/lib/vdpau:${pkgs.libglvnd}/lib

    cd ~
    start-hyprland --no-nixgl --path ~/.nix-profile/bin/hyprland
    EOF

    chmod +x $out/bin/start_hyprland

    cp waybar.jsonc $out/usr/config/waybar/config.jsonc
    cp hyprland.conf $out/usr/config/hypr/hyprland.conf

    sed -i -e 's#_XDPH_NIX_BINARY#${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland#g' $out/usr/config/hypr/hyprland.conf
    sed -i -e 's#_XDP_NIX_BINARY#${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal#g' $out/usr/config/hypr/hyprland.conf
    sed -i -e 's#_PIPEWIRE_NIX_BINARY#${pkgs.pipewire}/bin/pipewire#g' $out/usr/config/hypr/hyprland.conf
    sed -i -e 's#_WIREPLUMBER_NIX_BINARY#${pkgs.wireplumber}/bin/wireplumber#g' $out/usr/config/hypr/hyprland.conf
  '';
}
