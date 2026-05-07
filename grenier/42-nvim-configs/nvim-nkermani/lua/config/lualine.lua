-- lua/config/lualine.lua
-- nvim-lualine/lualine.nvim -> A blazing fast and easy to configure Neovim statusline written in Lua.
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then return end

local colors = {
    bg       = '#212121',
    fg       = '#cacaca',
    darkgrey = '#424242',
    yellow   = '#eedb85',
    cyan     = '#00f0ff',
    green    = '#51f66f',
    orange   = '#ff9e64',
    magenta  = '#d867c6',
    blue     = '#368aec',
    red      = '#f3505c',
    gold     = '#ffcc00',
}

local theme = {
    normal = {
        a = { fg = colors.bg, bg = colors.red, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
        x = { fg = colors.fg, bg = colors.bg },
        y = { fg = colors.bg, bg = colors.darkgrey, gui = 'bold' },
        z = { fg = colors.bg, bg = colors.red, gui = 'bold' },
    },
    insert = {
        a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
    },
    visual = {
        a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
    },
    replace = {
        a = { fg = colors.bg, bg = colors.red, gui = 'bold' },
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
        lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end, padding = { left = 1, right = 1 } } },
        lualine_b = { { 'branch', icon = '', padding = { left = 1, right = 1 } }, { 'diff', padding = { left = 1, right = 1 } } },
        lualine_c = { { 'filename', path = 1, symbols = { modified = ' ●', readonly = ' 🔒' }, padding = { left = 1, right = 1 } } },
        lualine_x = { { 'diagnostics', padding = { left = 1, right = 1 } }, { 'filetype', padding = { left = 1, right = 1 } } },
        lualine_y = { { 'progress', padding = { left = 1, right = 1 } } },
        lualine_z = { { 'location', padding = { left = 1, right = 1 } } },
    },
})

