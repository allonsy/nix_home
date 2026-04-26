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
    mkdir -p $out/etc/config/hypr
    mkdir -p $out/etc/config/waybar

    cp ${pkgs.hyprland}/bin/hyprland $out/bin/
    cp ${pkgs.hyprland}/bin/hyprctl $out/bin/
    cp ${pkgs.xwayland}/bin/Xwayland $out/bin/
    cp ${pkgs.hyprland}/bin/start-hyprland $out/bin/
    cp ${pkgs.waybar}/bin/waybar $out/bin/
    cp ${pkgs.swaybg}/bin/swaybg $out/bin/

    cat << EOF > $out/bin/start_hyprland
    #!/usr/bin/env zsh

    export GBM_BACKENDS_PATH=${pkgs.mesa}/lib/gbm
    export LIBGL_DRIVERS_PATH=${pkgs.mesa}/lib/dri
    export LIBVA_DRIVERS_PATH=${pkgs.mesa}/lib/dri:${pkgs.intel-media-driver}/lib/dri
    export __EGL_VENDOR_LIBRARY_FILENAMES=${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json
    export LD_LIBRARY_PATH=${pkgs.mesa}/lib:${pkgs.libvdpau-va-gl}/lib/vdpau:${pkgs.libglvnd}/lib
    export XDG_RUNTIME_DIR=/tmp/"\$(whoami)"/xdg
    export TZ='Asia/Tel_Aviv'

    eval \$(dbus-launch --sh-syntax --config-file=/usr/share/dbus-1/session.conf)

    mkdir -p \$XDG_RUNTIME_DIR

    cd ~
    start-hyprland --no-nixgl --path /usr/bin/hyprland
    EOF

    chmod +x $out/bin/start_hyprland

    cp waybar.jsonc $out/etc/config/waybar/config.jsonc
    cp hyprland.conf $out/etc/config/hypr/hyprland.conf

    sed -i -e 's#_XDPH_NIX_BINARY#${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland#g' $out/etc/config/hypr/hyprland.conf
    sed -i -e 's#_XDP_NIX_BINARY#${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal#g' $out/etc/config/hypr/hyprland.conf
    sed -i -e 's#_PIPEWIRE_NIX_BINARY#${pkgs.pipewire}/bin/pipewire#g' $out/etc/config/hypr/hyprland.conf
    sed -i -e 's#_WIREPLUMBER_NIX_BINARY#${pkgs.wireplumber}/bin/wireplumber#g' $out/etc/config/hypr/hyprland.conf
  '';
}
