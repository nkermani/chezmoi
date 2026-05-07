vim.api.nvim_set_hl(0, "ScrollbarHandle", { bg = "#444444", fg = "none" })

require("scrollbar").setup({
    show = true,
    zindex = 100,
    handle = {
        text = " ",
        color = "#444444",
        blend = 0,
        highlight = "ScrollbarHandle",
    },
    marks = {
        Search = { color = "#d867c6" },
        Error = { color = "#f3505c" },
        Warn = { color = "#eedb85" },
        Info = { color = "#368aec" },
        Hint = { color = "#51f66f" },
    },
    excluded_filetypes = {
        "neo-tree",
        "TelescopePrompt",
        "noice",
        "alpha",
        "toggleterm",
    },
})
