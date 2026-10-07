hl.config({
  input = {
    kb_layout    = "us,il",
    kb_variant   = "",
    kb_model     = "",
    kb_options   = "ctrl:nocaps,altwin:swap_alt_win",
    kb_rules     = "",

    follow_mouse = 1,

    sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad     = {
      natural_scroll = false,
    },
  },
})

hl.device({
  name        = "epic-mouse-v1",
  sensitivity = -0.5,
})
