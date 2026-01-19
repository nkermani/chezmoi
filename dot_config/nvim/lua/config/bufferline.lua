local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
	options = {
		mode = "buffers", -- Tabs will show open buffers
		separator_style = "slant", -- VSCode-like slant separator
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
