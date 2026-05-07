return {
	enabled = vim.g.host == "home",
	"epwalsh/obsidian.nvim", version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cmd = { "ObsidianQuickSwitch" },
	keys = {
		{ "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Open" },
		{ "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Open" },
		{ "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search" },
		{ "<leaderon>", "<cmd>ObsidianNew<cr>", desc = "Obsidian New" },
	},
	opts = {
		ui = { enable = false },

		workspaces = {
			{ name = "notes", path = "~/doc/notes" },
		},

		completion = { nvim_cmp = false }, -- TODO

		disable_frontmatter = true,

		daily_notes = {
			folder = "dailies",
			date_format = "%Y-%m-%d",
			alias_format = "%B %-d, %Y",
		},

		-- mappings = {},

		note_id_func = function(title)
			if title ~= nil then
				return os.date("%y%m%d-") .. title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				return os.date("%y%m%d-%H%M%S")
			end
		end,

		follow_url_func = function(url) vim.fn.jobstart({"xdg-open", url}) end,
	}
}
