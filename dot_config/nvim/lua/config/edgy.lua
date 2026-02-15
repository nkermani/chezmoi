local ok, edgy = pcall(require, "edgy")
if not ok then return end

edgy.setup({
    left = {
        {
            title = "EXPLORER",
            ft = "neo-tree",
            show = function()
                return vim.api.nvim_win_get_width(0) > 30
            end,
            pinned = true,
            open = "Neotree show",
        },
    },
    bottom = {
        {
            ft = "toggleterm",
            size = { height = 0.4 },
            filter = function(buf, win)
                return vim.api.nvim_win_get_config(win).relative == ""
            end,
        },
        {
            ft = "noice",
            size = { height = 0.4 },
            filter = function(buf, win)
                return vim.api.nvim_win_get_config(win).relative == ""
            end,
        },
        {
            ft = "Trouble",
            title = "Trouble",
            size = { height = 0.3 },
        },
        { ft = "qf", title = "Quickfix" },
        { ft = "help", size = { height = 20 } },
    },
    right = {
        { title = "Gitsigns", ft = "gitsigns.summary" },
    },
    options = {
        left = { size = 35 },
        bottom = { size = 10 },
        right = { size = 30 },
        top = { size = 10 },
    },
    animate = {
        enabled = false,
    },
    exit_when_last = false,
    wo = {
        winbar = true,
        winhighlight = "Normal:Normal,NormalNC:NormalNC,WinSeparator:WinSeparator",
    },
})
