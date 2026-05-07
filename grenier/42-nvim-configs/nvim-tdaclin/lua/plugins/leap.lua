return {
	"https://codeberg.org/andyg/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	lazy = false,
	keys = {
		{ "s", "<Plug>(leap)", mode = { "n", "x", "o" } },
		-- { "<leader>s", "<Plug>(leap-from-window)" },
	}
}
