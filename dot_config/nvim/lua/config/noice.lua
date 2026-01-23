-- lua/config/noice.lua
-- folke/noice.nvim -> Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
require("noice").setup({
    lsp = { override = { ["vim.lsp.util.convert_input_to_markdown_lines"] = true } },
    presets = { bottom_search = true, command_palette = true, long_message_to_split = true },
})
