return {
	enabled = vim.g.host ~= "home",
	"mason-org/mason-lspconfig.nvim", version = "2.*",
	dependencies = {
		{
			"mason-org/mason.nvim", version = "2.*",
			opts = { }
		},
		{ "neovim/nvim-lspconfig" },
	},
	opts = {
		ensure_installed = {
			"clangd", "pyright", "rust_analyzer",
			"ts_ls", "eslint", "svelte", "tailwindcss"
			-- maybe use eslint_d if too slow, maybe add prettierd
		},
	}
}
