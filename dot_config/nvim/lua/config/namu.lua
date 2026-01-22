-- lua/config/namu.lua
local ok, namu = pcall(require, "namu")
if not ok then return end

namu.setup({
    namu_symbols = {
        enable = true,
        options = {
            window = {
                border = "rounded",
                relative = "editor",
            },
        },
    },
})

-- Raccourci pour chercher une fonction/symbole dans le fichier
vim.keymap.set("n", "<leader>s", function() require("namu.namu_symbols").show() end, { desc = "Search Symbols (Namu)" })

