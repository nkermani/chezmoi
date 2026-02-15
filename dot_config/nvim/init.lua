-- Neovim Configuration File
-- init.lua
-- Core
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Configs
-- require("config.mason") -- Disabled for instant startup
require("config.colorscheme")
-- require("config.transparent")

require("config.copilot")
require("config.snacks")

require("config.devicons")
require("config.lualine")
require("config.bufferline")
require("config.gitsigns")
require("config.treesitter")
require("config.neotree")
require("config.edgy")
require("config.toggleterm")
require("config.outline")
require("config.namu")
require("config.telescope")
require("config.cmp")

-- require("config.lspconfig") -- Disabled for instant startup
require("config.noice")
require("config.dressing")
require("config.autopairs")
require("config.conform")
require("config.trouble")
require("config.multicursor")
require("config.vim_visual_multi")
require("config.oil")
-- require("config.no_neck_pain")
require("config.inlinediff")
require("config.codediff")
require("config.btw")
require("config.spectre")

-- LSP (Local & Fast)
require("lsp").setup({})
