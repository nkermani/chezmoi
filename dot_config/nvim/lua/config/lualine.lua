-- lua/config/lualine.lua
-- nvim-lualine/lualine.nvim -> A blazing fast and easy to configure Neovim statusline written in Lua.
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then return end

lualine.setup({
    options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { "alpha", "neo-tree", "oil", "edgy" },
    },
    sections = {
        lualine_a = { { 'mode', fmt = function(str) return str:sub(1,1) end } },
        lualine_b = { 'branch' },
        lualine_c = { { 'filename', path = 1, symbols = { modified = ' ●', readonly = ' 🔒' } } },
        lualine_x = { 'diagnostics', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
})
