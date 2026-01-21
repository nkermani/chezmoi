local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
    options = {
        mode = "buffers",
        separator_style = "slant",
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        color_icons = true,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        offsets = {
            {
                filetype = "neo-tree",
                text = "Explorer",
                highlight = "Directory",
                text_align = "left",
            },
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

