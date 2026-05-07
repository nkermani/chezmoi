require("noice").setup({
    lsp = {
        override = { ["vim.lsp.util.convert_input_to_markdown_lines"] = true },
        progress = { enabled = false },
    },
    presets = { bottom_search = true, command_palette = true, long_message_to_split = true },
    views = {
        cmdline_popup = {
            position = {
                row = "40%",
                col = "50%",
            },
            size = {
                width = 60,
                height = "auto",
            },
            border = {
                style = "rounded",
                padding = { 0, 1 },
            },
            filter_options = {},
            win_options = {
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            },
        },
        popup = {
            border = {
                style = "rounded",
            },
            win_options = {
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            },
        },
    },
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
