return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"onsails/lspkind.nvim",
		"xzbdmw/colorful-menu.nvim",
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		{
			"L3MON4D3/LuaSnip", version = "2.*",
			build = "make install_jsregexp",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
		},
	},
	event = { "InsertEnter", "CmdlineEnter" },
	opts = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		return {
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "calc" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "nvim_lsp_signature_help" },
			},
			snippet = {
				expand = function(args) luasnip.lsp_expand(args.body) end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true
				}),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),

				["<C-l>"] = cmp.mapping(function(fallback)
					if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() else fallback() end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end
				end, { "i", "s" }),
			}),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			view = {
				entries = "custom" -- can be "custom", "wildmenu" or "native"
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "text_symbol",
					maxwidth = function() return math.floor(0.3 * vim.o.columns) end,
					ellipsis_char = "...",
				})
			}
		}
	end
}
