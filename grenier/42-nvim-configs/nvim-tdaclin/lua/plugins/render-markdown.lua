return {
	"MeanderingProgrammer/render-markdown.nvim",
	lazy = true,
	cmd = "RenderMarkdown",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons"
	},
	opts = {
		completions = { lsp = { enabled = true } },
	}
}
