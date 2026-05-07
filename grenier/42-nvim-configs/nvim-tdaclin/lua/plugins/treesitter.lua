return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		filetypes = {
			"lua", "vim", "vimdoc",
			"comment", "csv", "json5", "toml", "yaml",
			"git_rebase", "gitcommit", "gitignore",
			"markdown", "markdown_inline",
			"c", "cpp", "make", "cmake", "meson",
			"bash", "nix", "python", "rust", "zig", "nasm",
			"dockerfile", "caddy", "nginx",
			"css", "scss", "html", "svelte",
			"javascript", "jsdoc", "typescript",
			"sql", "prisma", "sway",
		}
		require("nvim-treesitter").install(filetypes)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldmethod = "expr"
			end,
		})
	end,
}

--- for nvim v11
-- return {
-- 	"nvim-treesitter/nvim-treesitter", version = "0.*",
-- 	build = ":TSUpdate",
-- 	main = "nvim-treesitter.configs",
-- 	opts = {
-- 		ensure_installed = {
-- 			"lua", "vim", "vimdoc",
-- 			"comment", "csv", "json5", "toml", "yaml",
-- 			"git_rebase", "gitcommit", "gitignore",
-- 			"markdown", "markdown_inline",
-- 			"c", "cpp", "make", "cmake", "meson",
-- 			"bash", "nix", "python", "rust", "zig", "nasm",
-- 			"dockerfile", "caddy", "nginx",
-- 			"css", "scss", "html", "svelte",
-- 			"javascript", "jsdoc", "typescript",
-- 			"sql", "prisma", "sway",
-- 		},
-- 		highlight = { enable = true },
-- 		indent = { enable = true },
-- 		incremental_selection = { enable = true },
-- 	},
-- 	config = function(plugin, opts)
-- 		require(plugin.main).setup(opts)
-- 	end,
-- }
