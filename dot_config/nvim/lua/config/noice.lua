-- lua/config/noice.lua
-- folke/noice.nvim -> Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
require("noice").setup({
    lsp = { 
        override = { ["vim.lsp.util.convert_input_to_markdown_lines"] = true },
        -- Désactive le message "LSP Progress" qui spamme lors de la sauvegarde
        progress = { enabled = false },
    },
    presets = { bottom_search = true, command_palette = true, long_message_to_split = true },
    -- Filtrer les messages de notification spammy
    routes = {
        {
            filter = {
                event = "msg_show",
                kind = "",
                find = "written",
            },
            opts = { skip = true },
        },
    },
})
