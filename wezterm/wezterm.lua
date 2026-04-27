local wezterm = require 'wezterm'
return {
  default_prog = { 'wsl.exe', '-d', 'Ubuntu' },
  font = wezterm.font('Cascadia Code'),
  font_size = 12.0,
  color_scheme = 'Catppuccin Mocha',
  window_decorations = "RESIZE",
  window_padding = { left = 8, right = 8, top = 8, bottom = 8 },
  window_background_opacity = 0.95,
  keys = {
    { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
    { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
  },
}
