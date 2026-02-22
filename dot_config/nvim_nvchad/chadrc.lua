local M = {}

M.ui = {
  theme = "tokyonight",
  theme_toggle = { "tokyonight", "one_light" },
  transparency = false,
  statusline = {
    theme = "default",
    separator_style = "round",
    overriden_modules = nil,
  },
  hl_override = {},
  hl_add = {},
  CMP = {
    icons = true,
    lspkind_text = true,
    style = "default",
    border_style = "single",
    selected_item_bg = "colored",
  },
}

M.plugins = "custom.plugins"

M.mappings = require("custom.mappings")

M.default_plugin = {
  delete_buffer = true,
  diffview = true,
  toggle_theme = true,
}

return M
