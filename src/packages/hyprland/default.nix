{
  pkgs,
  stdenv,
  utils,
  vars,
  ...
}:
let
  hyprland_start_script = utils.writeTemplate ./src/start_hyprland {
    gbm_backends_path = "${pkgs.mesa}/lib/gbm";
    libgl_drivers_path = "${pkgs.mesa}/lib/dri";
    libva_drivers_path = "${pkgs.mesa}/lib/dri:${pkgs.intel-media-driver}/lib/dri";
    egl_vendor_library_filenames = "${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json";
    ld_library_path = "${pkgs.mesa}/lib:${pkgs.libvdpau-va-gl}/lib/vdpau:${pkgs.libglvnd}/lib";
    time_zone = vars.timeZone;
  };
  autostart_script = utils.writeTemplate ./src/hypr/autostart.lua {
    dph_nix_binary = "${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland";
    dp_nix_binary = "${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal";
    pipewire_binary = "${pkgs.pipewire}/bin/pipewire";
    wireplumber_binary = "${pkgs.wireplumber}/bin/wireplumber";
  };
in
stdenv.mkDerivation {
  name = "hyprland";
  src = ./src;

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
    cp ${hyprland_start_script} $out/bin/start_hyprland

    chmod +x $out/bin/start_hyprland

    cp waybar.jsonc $out/etc/config/waybar/config.jsonc
    cp -r hypr/* $out/etc/config/hypr
    cp ${autostart_script} $out/etc/config/hypr/autostart.lua

  '';
}
