return {
	"nvim-tree/nvim-tree.lua", version = "1.*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	keys = {
		{ "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
		{ "<leader>ft", "<cmd>NvimTreeFindFile<cr>", desc = "NvimTree open current file" },
	},
	opts = { }
}
