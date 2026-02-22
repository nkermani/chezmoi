-- lua/config/btw.lua
-- letieu/btw.nvim -> Makes a I use NVIM Btw screen start
local ok, btw = pcall(require, "btw")
if not ok then return end

require("btw").setup({})

