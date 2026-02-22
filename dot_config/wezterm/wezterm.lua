-- wezterm configuration
-- Based on kitty config style with cyberpunk theme

-- Enable Kitty Keyboard Protocol
enable_kitty_keyboard_protocol = true

-- General settings
local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Appearance
config.color_scheme = 'cyberpunk' -- Base, we'll customize below
config.font = wezterm.font_with_fallback {
  'JetBrainsMono Nerd Font',
}
config.font_size = 12.0
config.font_offset_x = -1
config.font_offset_y = -1

config.window_decorations = "RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_background_opacity = 1.0
config.window_maximized = true

-- Cursor
config.default_cursor_style = 'BlinkingBeam'
config.cursor_blink_rate = 500

-- Scrollback
config.scrollback_lines = 10000

-- Custom cyberpunk colors (matching alacritty)
config.colors = {
  foreground = '#cacaca',
  background = '#212121',
  cursor_bg = '#cacaca',
  cursor_border = '#cacaca',
  cursor_fg = '#212121',
  selection_bg = '#343434',
  selection_fg = '#cacaca',

  ansi = {
    '#212121',  -- black
    '#f3505c',  -- red
    '#51f66f',  -- green
    '#eedb85',  -- yellow
    '#368aec',  -- blue
    '#d867c6',  -- magenta
    '#00f0ff',  -- cyan
    '#cacaca',  -- white
  },

  brights = {
    '#676767',  -- bright black
    '#f3505c',  -- bright red
    '#51f66f',  -- bright green
    '#eedb85',  -- bright yellow
    '#368aec',  -- bright blue
    '#d867c6',  -- bright magenta
    '#00f0ff',  -- bright cyan
    '#ffffff',  -- bright white
  },

  indexed = {
    [16] = '#f0c808',
    [17] = '#e4ffff',
  },

  scrollbar_thumb = '#343434',
  split = '#343434',
}

-- Link actions
config.handle_link_click = function(window, mouse_button, link)
  if mouse_button == 'Left' then
    wezterm.open_with(link)
  end
end

-- Mouse bindings
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Middle' } },
    action = wezterm.action.PasteSelection 'PrimarySelection',
    mods = 'NONE',
  },
}

-- Keyboard bindings
config.keybindings = {
  { key = 'v', mods = 'CTRL', action = 'Paste' },
  { key = 'V', mods = 'CTRL|SHIFT', action = 'Paste' },
  { key = 'c', mods = 'CTRL|SHIFT', action = 'Copy' },
}

-- Wayland / X11 env
config.enable_wayland = false

return config
