local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Bright (base16)'
config.window_background_opacity = 0.7
config.font = wezterm.font 'Fira Code'
config.font_size = 13

config.hide_tab_bar_if_only_one_tab = true

config.scrollback_lines = 10000
config.enable_scroll_bar = false

return config
