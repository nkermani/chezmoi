-- lua/config/lualine.lua

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then return end

lualine.setup({
    options = {
        -- REMPLACEZ "kanagawa" PAR "one_monokai" OU "auto"
        theme = "one_monokai",
        globalstatus = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
    },
})

-- local ok, lualine = pcall(require, "lualine")
-- if not ok then return end
--
-- local custom_kanagawa = require('lualine.themes.kanagawa')
--
-- -- On définit les sections que l'on veut rendre transparentes (b et c)
-- local sections_to_clear = { 'b', 'c' }
--
-- for _, mode in pairs({ 'normal', 'insert', 'visual', 'replace', 'command', 'inactive' }) do
--     for _, section in ipairs(sections_to_clear) do
--         if custom_kanagawa[mode] and custom_kanagawa[mode][section] then
--             custom_kanagawa[mode][section].bg = 'NONE'
--         end
--     end
-- end
--
-- lualine.setup({
--     options = {
--         theme = custom_kanagawa,
--         icons_enabled = true,
--         component_separators = '|',
--         section_separators = '',
--     },
--     sections = {
--         lualine_b = { 'branch', 'diff', 'diagnostics' },
--         lualine_c = { 'filename' },
--     },
-- })

