local function makeSelectBinding(keys, txtobj)
	action = function()
		require("nvim-treesitter-textobjects.select").select_textobject(txtobj, "textobjects")
	end
	return { keys, action, mode = { "x", "o" } }
end

local function makeGotoBinding(keys, txtobj, cmd)
	action = function()
		require("nvim-treesitter-textobjects.move")["goto_" .. cmd](txtobj, "textobjects")
	end
	return { keys, action, mode = { "n", "x", "o" } }
end

return {
	"nvim-treesitter/nvim-treesitter-textobjects", branch = "main",
	lazy = false,
	opts = {
		select = {
			selection_modes = {
				["@function.outer"] = "V",
				["@function.inner"] = "V",
			},
		},
	},
	keys = {
		makeSelectBinding("af", "@function.outer"),
		makeSelectBinding("if", "@function.inner"),

		makeGotoBinding("]f", "@function.outer", "next_start"),
		makeGotoBinding("]F", "@function.outer", "next_end"),
		makeGotoBinding("[f", "@function.outer", "previous_start"),
		makeGotoBinding("[F", "@function.outer", "previous_end"),

		{ "<leader>a", function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end },
		{ "<leader>A", function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer") end },
	}
}
