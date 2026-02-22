-- lua/core/keymaps/general.lua
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Navigation rapide entre les splits avec Ctrl + hjkl
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Raccourcis plus intuitifs pour split (ex: leader + | ou -)
keymap("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split vertical" })
keymap("n", "<leader>-", "<cmd>split<cr>", { desc = "Split horizontal" })

-- Recherche dans le fichier courant avec CTRL+F
keymap("n", "<C-f>", "/", { desc = "Search" })
keymap("v", "<C-f>", [[y/<C-r>"<CR>]], { desc = "Search visual selection" })
keymap("i", "<C-f>", "<ESC>/", { desc = "Search from Insert" })

-- Clear search highlights
keymap("n", "<Esc>", "<cmd>noh<cr><Esc>", { desc = "Clear search highlights" })

-- Toggle les numéros de ligne
keymap('n', '<leader>nl', function()
    vim.opt.number = not vim.opt.number:get()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle Line Numbers" })

-- Toggle Diagnostics
keymap("n", "<leader>td", function()
    local is_enabled = vim.diagnostic.is_enabled()
    vim.diagnostic.enable(not is_enabled)
    local status = is_enabled and "OFF" or "ON"
    vim.notify("Diagnostics " .. status, vim.log.levels.INFO, { title = "LSP Diagnostics" })
end, { desc = "Toggle Diagnostics" })

-- SCROLL VERTICAL (ALT + MOLETTE)
keymap({ 'n', 'i', 'v' }, '<M-ScrollWheelDown>', '15<C-e>', opts)
keymap({ 'n', 'i', 'v' }, '<M-ScrollWheelUp>', '15<C-y>', opts)

-- SCROLL HORIZONTAL (SHIFT + MOLETTE)
keymap({ 'n', 'i', 'v' }, '<S-ScrollWheelDown>', '5zh', opts)
keymap({ 'n', 'i', 'v' }, '<S-ScrollWheelUp>', '5zl', opts)

-- VISUAL BLOCK MODE
keymap('n', '<leader>v', '<C-v>', { desc = "Visual Block Mode" })

-- Force Quit
keymap({ 'n', 'i', 'v' }, '<C-S-q>', ':q!<CR>', { desc = "Force Quit" })

-- Plugin Management
keymap('n', '<leader>pi', function()
    dofile(vim.fn.stdpath("config") .. "/lua/plugins.lua")
    vim.notify("Vérification des plugins en cours...", vim.log.levels.INFO)
end, { desc = "Plugins Install/Check" })

keymap('n', '<leader>ps', ':!./sync_plugins.sh<CR>', { desc = "Sync Plugins to Start" })

-- Désactiver l'historique des commandes
keymap("n", "q:", "<nop>", opts)
keymap("n", "q/", "<nop>", opts)
keymap("n", "q?", "<nop>", opts)
keymap("v", "q:", "<nop>", opts)
