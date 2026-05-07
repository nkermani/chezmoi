local ok, bufferline = pcall(require, "bufferline")
if ok then
  bufferline.setup({
    options = {
      mode = "buffers",
      style_preset = bufferline.style_preset.default,
      separator_style = "thick",
      indicator = { style = 'bold' },
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      show_buffer_icons = true,
      color_icons = true,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      close_command = function(n) require("snacks").bufdelete(n) end,
      right_mouse_command = function(n) require("snacks").bufdelete(n) end,
      offsets = { { filetype = "neo-tree", text = "EXPLORER", text_align = "center", highlight = "EdgyTitle", separator = true } },
      hover = { enabled = false },
    },
  })
end
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
