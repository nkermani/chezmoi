-- lua/config/oil.lua
-- stevearc/oil.nvim -> A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer
local ok, oil = pcall(require, "oil")
if not ok then return end

require("oil").setup({})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
