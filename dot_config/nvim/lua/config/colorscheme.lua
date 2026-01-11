-- lua/config/colorscheme.lua
local ok, kanagawa = pcall(require, "kanagawa")
if not ok then return end

kanagawa.setup({})

vim.cmd("colorscheme kanagawa")
