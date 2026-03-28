-- lua/config/spectre.lua
-- nvim-pack/nvim-spectre -> Search and Replace across files
local ok, spectre = pcall(require, "spectre")
if not ok then return end

spectre.setup({
    is_live_distance = true, -- remplace au fur et à mesure
    open_cmd = 'vnew',       -- ouvre dans un split vertical
    highlight = {
        ui = "String",
        search = "DiffDelete",
        replace = "DiffAdd",
    }
})

local keymap = vim.keymap.set
-- Ouvrir Spectre pour tout le projet
keymap('n', '<leader>R', '<cmd>lua require("spectre").toggle()<CR>', { desc = "Replace in project (Spectre)" })
-- Chercher le mot sous le curseur dans tout le projet
keymap('n', '<leader>rw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
    { desc = "Replace current word" })
