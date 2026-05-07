
function display_big_line_length()
	size = vim.fn.strdisplaywidth(vim.fn.getline('.'))
	if size > 80 then
		return size
	end
	return ""
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			globalstatus = true,
			section_separators = { left = "", right = "" },
			component_separators = { left = "|", right = "|" },
		},
		extensions = { "man", "quickfix", "nvim-tree" },
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "filename" },
			lualine_c = { "branch", "diff", "diagnostics", "searchcount" },
			lualine_x = { "selectioncount", { "filetype", icon = { align = "right" } } },
			lualine_y = { "progress", display_big_line_length },
			lualine_z = { "location" }
		},
	}
}
