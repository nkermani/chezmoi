local status_ok, lualine = pcall(require, "lualine")
if not status_ok then return end

lualine.setup({
    options = {
        theme = "auto",
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
