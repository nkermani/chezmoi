local ok, dressing = pcall(require, "dressing")
if not ok then return end

dressing.setup({
    input = {
        enabled = true,
        default_prompt = "➤ ",
        border = "rounded",
        relative = "cursor",
        prefer_width = 40,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        win_options = {
            winblend = 0,
        },
    },
    select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        trim_and_pad = true,
        telescope = require('telescope.themes').get_cursor(),
    },
})
