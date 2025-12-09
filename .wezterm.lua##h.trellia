local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Bright (base16)'
config.window_background_opacity = 0.7
config.font = wezterm.font 'Fira Code'
config.font_size = 14

config.window_decorations = "NONE"
config.hide_tab_bar_if_only_one_tab = true

config.scrollback_lines = 10000
config.enable_scroll_bar = false

config.enable_wayland = false

config.leader = {
  key = 'b',
  mods = 'CTRL',
  timeout_milliseconds = 2000,
}

config.keys = {
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  {
    key = '"',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane{ confirm = true },
  },
  {
    key = 'RightArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection('Right'),
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection('Left'),
  },
  {
    key = 'UpArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection('Up'),
  },
  {
    key = 'DownArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection('Down'),
  },
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },
}

return config
