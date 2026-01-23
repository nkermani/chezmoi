-- lua/config/lualine.lua
-- nvim-lualine/lualine.nvim -> A blazing fast and easy to configure Neovim statusline written in Lua.
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then return end

lualine.setup({
    options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
    },
})
