return {
	"chrishrb/gx.nvim", version = "*",
	keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
	cmd = { "Browse" },
	init = function () vim.g.netrw_nogx = 1 end,
	submodules = false,
	opts = {}
}
