-- lua/config/lualine.lua
-- nvim-lualine/lualine.nvim -> A blazing fast and easy to configure Neovim statusline written in Lua.
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then return end

local colors = {
    bg       = '#252526',
    fg       = '#cacaca',
    yellow   = '#eedb85',
    cyan     = '#00f0ff',
    darkblue = '#081633',
    green    = '#51f66f',
    orange   = '#ffc07a',
    violet   = '#d867c6',
    magenta  = '#d867c6',
    blue     = '#368aec',
    red      = '#f3505c',
}

local theme = {
    normal = {
        a = { fg = colors.cyan, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
    },
    insert = {
        a = { fg = colors.green, bg = colors.bg, gui = 'bold' },
    },
    visual = {
        a = { fg = colors.magenta, bg = colors.bg, gui = 'bold' },
    },
    replace = {
        a = { fg = colors.red, bg = colors.bg, gui = 'bold' },
    },
    inactive = {
        a = { fg = colors.fg, bg = colors.bg },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
    },
}

lualine.setup({
    options = {
        theme = theme,
        globalstatus = true,
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { "alpha", "neo-tree", "oil", "edgy" },
    },
    sections = {
        lualine_a = { { 'mode', fmt = function(str) return str:sub(1,1) end } },
        lualine_b = { { 'branch', icon = '' }, 'diff' },
        lualine_c = { { 'filename', path = 1, symbols = { modified = ' ●', readonly = ' 🔒' } } },
        lualine_x = { 'diagnostics', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
})
