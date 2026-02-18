require("scrollbar").setup({
    show = true,
    handle = {
        text = " ",
        color = "#00f0ff",
        cterm = nil,
        highlight = "CursorColumn",
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
