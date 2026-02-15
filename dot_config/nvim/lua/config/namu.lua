-- lua/config/namu.lua
-- bassamsdata/namu.nvim -> Jump to symbols in your code with live preview

local ok, namu = pcall(require, "namu")
if not ok then return end

namu.setup({
    namu_symbols = {
        enable = true,
        options = {
            window = {
                border = "rounded",
                relative = "editor",
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            },
        },
    },
})

vim.keymap.set("n", "<leader>s", "<cmd>Namu symbols<cr>", {
    desc = "Jump to LSP symbol",
    silent = true,
})
