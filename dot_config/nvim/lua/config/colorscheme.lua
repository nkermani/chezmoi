-- lua/config/colorscheme.lua
-- Colorscheme file
-- rebelot/kanagawa.nvim
-- cpea2506/one_monokai.nvim
-- sainnhe/sonokai

local ok_monokai, monokai = pcall(require, "one_monokai")
local ok_kanagawa, kanagawa = pcall(require, "kanagawa")
local ok_sonokai, sonokai = pcall(require, "sonokai")

-- 1. Sonokai
if ok_sonokai then
    vim.g.sonokai_style = 'shusia'
    vim.g.sonokai_transparent_background = 1
    vim.g.sonokai_better_performance = 1
end

-- 2. Kanagawa
if ok_kanagawa then
    kanagawa.setup({
        transparent = true, -- Pour le flou/blur
        theme = "wave",
    })
end

if ok_monokai then
    monokai.setup({
        transparent = true, -- Pour le flou/blur
    })
end

if ok_sonokai then
    vim.cmd("colorscheme sonokai")
elseif ok_monokai then
    vim.cmd("colorscheme one_monokai")
elseif ok_kanagawa then
    vim.cmd("colorscheme kanagawa")
else
    vim.cmd("colorscheme industry")
end
