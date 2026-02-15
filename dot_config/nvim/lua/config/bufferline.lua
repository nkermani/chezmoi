-- lua/config/bufferline.lua
local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

bufferline.setup({
    options = {
        mode = "buffers",
        style_preset = bufferline.style_preset.default,
        separator_style = "thin",
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        color_icons = true,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        close_command = function(n) require("snacks").bufdelete(n) end,
        right_mouse_command = function(n) require("snacks").bufdelete(n) end,
        offsets = {
            {
                filetype = "neo-tree",
                text = "EXPLORER",
                text_align = "center",
                highlight = "EdgyTitle",
                separator = true,
            },
        },
        hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' }
        },
    },
})

local trans_ok, transparent = pcall(require, "transparent")
if trans_ok then
    transparent.clear_prefix('BufferLine')

    vim.g.transparent_groups = vim.list_extend(
        vim.g.transparent_groups or {},
        vim.tbl_map(function(v)
            return v.hl_group
        end, vim.tbl_values(require('bufferline.config').highlights))
    )
end

vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })

