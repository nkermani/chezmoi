-- lua/config/noice.lua
require("noice").setup({
    lsp = { override = { ["vim.lsp.util.convert_input_to_markdown_lines"] = true } },
    presets = { bottom_search = true, command_palette = true, long_message_to_split = true },
})
