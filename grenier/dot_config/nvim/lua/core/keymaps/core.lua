---@diagnostic disable: undefined-global
-- [[ --------------------- KEYMAP OVERVIEW --------------------- ]]
--
-- Leader key: "," (comma)
--
-- ---------------------------------------------------------------
--  Window & Navigation
-- ---------------------------------------------------------------
--   <C-h/j/k/l>  (n) : Window navigation (Left/Down/Up/Right)
--   <leader>|    (n) : Vertical split
--   <leader>-    (n) : Horizontal split
--   <leader>v    (n) : Visual Block Mode
--   <Esc>        (n) : Clear search highlights
--   <leader>nl   (n) : Toggle line numbers
--
-- ---------------------------------------------------------------
--  Disabled Defaults
-- ---------------------------------------------------------------
--   <C-d/u>      (n,v,i) : Disabled (for multicursor)
--   <C-z/S-z>    (n,v,i) : Disabled (suspend)
--   q:, q/, q?, q(n,v)   : Disabled (command history/macro)
--
-- [[ ----------------------------------------------------------- ]]
-- lua/core/keymaps/core.lua
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

-- Clear search highlights
keymap("n", "<Esc>", "<cmd>noh<cr><Esc>", { desc = "Clear search highlights" })

-- Toggle les numéros de ligne
keymap('n', '<leader>nl', function()
    vim.opt.number = not vim.opt.number:get()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle Line Numbers" })

-- DÉSACTIVER le scroll par défaut de CTRL+D pour laisser multicursor l'utiliser
keymap({ 'n', 'v', 'i' }, '<C-d>', '<nop>', { noremap = false })
keymap({ 'n', 'v', 'i' }, '<C-u>', '<nop>', { noremap = false })

-- Désactive la suspension de Neovim avec CTRL+Z
keymap({ 'n', 'v', 'i' }, '<C-z>', '<nop>')
keymap({ 'n', 'v', 'i' }, '<C-S-z>', '<nop>')

-- VISUAL BLOCK MODE
keymap('n', '<leader>v', '<C-v>', { desc = "Visual Block Mode" })

-- DÉSACTIVER L'HISTORIQUE DES COMMANDES
keymap("n", "q:", "<nop>", opts)
keymap("n", "q/", "<nop>", opts)
keymap("n", "q?", "<nop>", opts)
keymap("v", "q:", "<nop>", opts)
keymap("n", "q", "<nop>", opts)
