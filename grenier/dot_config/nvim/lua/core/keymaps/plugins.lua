---@diagnostic disable: undefined-global
-- [[ --------------------- KEYMAP OVERVIEW --------------------- ]]
--
-- Leader key: "," (comma)
--
-- ---------------------------------------------------------------
--  Plugins & Search
-- ---------------------------------------------------------------
--   <C-p/S-p>    (n,v,i) : Command Palette (Telescope)
--   fw / <C-S-f> (n)     : Live Grep (Telescope)
--   <C-f>        (n,v,i) : Search (Native / Visual selection)
--   <leader>pi   (n)     : Plugins Install/Check
--   <leader>ps   (n)     : Sync Plugins to Start
--   <S-h/l>      (n)     : Buffer navigation (Prev/Next)
--   <M-w> / <leader>x (n,v,i) : Smart Close (Pane or Buffer)
--   <leader>tp   (n)     : Toggle Precognition
--   <leader>td   (n)     : Toggle Diagnostics
--
-- [[ ----------------------------------------------------------- ]]
-- lua/core/keymaps/plugins.lua
local keymap = vim.keymap.set

-- Command Palette
keymap({ 'n', 'v', 'i' }, "<C-p>", ":Telescope commands<CR>", { desc = "Command Palette" })
keymap({ 'n', 'v', 'i' }, "<C-S-p>", ":Telescope commands<CR>", { desc = "Command Palette" })

-- Recherche de texte dans tout le projet (Live Grep)
keymap("n", "fw", ":Telescope live_grep<CR>", { desc = "Search text in project" })

-- Recherche dans le fichier courant avec CTRL+F
keymap("n", "<C-f>", "/", { desc = "Search" })
keymap("v", "<C-f>", [[y/<C-r>"<CR>]], { desc = "Search visual selection" })
keymap("i", "<C-f>", "<ESC>/", { desc = "Search from Insert" })

-- Si tu veux vraiment un raccourci proche de VSCode (CTRL+Maj+F)
keymap("n", "<C-S-f>", ":Telescope live_grep<CR>", { desc = "Search text in project" })

-- Raccourci pour INSTALLER (ne le faire que si tu ajoutes un plugin)
vim.keymap.set('n', '<leader>pi', function()
    dofile(vim.fn.stdpath("config") .. "/lua/plugins.lua")
    vim.notify("Vérification des plugins en cours...", vim.log.levels.INFO)
end, { desc = "Plugins Install/Check" })

-- Raccourci pour synchroniser vers START après l'install
vim.keymap.set('n', '<leader>ps', ':!./sync_plugins.sh<CR>', { desc = "Sync Plugins to Start" })

-- BUFFERLINE (TABS) NAVIGATION
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })
keymap({ "n", "i", "v" }, "<M-w>", function() _G.smart_close() end, { desc = "Smart Close (Pane or Buffer)" })
keymap("n", "<leader>x", function() _G.smart_close() end, { desc = "Smart Close (Pane or Buffer)" })

keymap("n", "<leader>tp", function()
    local ok, precognition = pcall(require, "precognition")
    if ok then
        precognition.toggle()
        local status = precognition.is_visible and "ON" or "OFF"
        vim.notify("Precognition " .. status, vim.log.levels.INFO, { title = "Precognition" })
    end
end, { desc = "Toggle Precognition" })

keymap("n", "<leader>td", function()
    local is_enabled = vim.diagnostic.is_enabled()
    vim.diagnostic.enable(not is_enabled)
    local status = is_enabled and "OFF" or "ON"
    vim.notify("Diagnostics " .. status, vim.log.levels.INFO, { title = "LSP Diagnostics" })
end, { desc = "Toggle Diagnostics" })

-- Auto-indentation for specific characters
local chars = { ',', '.', '!', '?', ';', ' ', '(', ')', '[', ']', '{', '}' }
for _, char in ipairs(chars) do
    keymap('i', char, char .. '<c-g>u', { noremap = true, silent = true })
end
