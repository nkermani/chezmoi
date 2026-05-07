return {
	"nvim-telescope/telescope.nvim", version = "0.*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>f?", "<cmd>Telescope<cr>", desc = "Telescope Commands" },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
		{ "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search" },
		{ "<leader>fv", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Search" },
		{ "<leader>fV", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Search" },
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Search Word" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
		{ "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
		{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits" },
		{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git Status" },
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzf")
	end,
	opts = function()
		local actions = require("telescope.actions")
		return {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
		}
	end
}
