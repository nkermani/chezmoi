-- lua/config/gitsigns.lua
-- lewis6991/gitsigns.nvim -> Only to get lines which got modified
local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

gitsigns.setup({
    current_line_blame = true,
})
