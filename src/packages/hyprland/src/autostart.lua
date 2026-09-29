-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("swaybg -c 222222")
  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
  hl.exec_cmd("_XDPH_NIX_BINARY")
  hl.exec_cmd("_XDP_NIX_BINARY")
  hl.exec_cmd("_PIPEWIRE_NIX_BINARY")
  hl.exec_cmd("_WIREPLUMBER_NIX_BINARY")
  hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
end
)
