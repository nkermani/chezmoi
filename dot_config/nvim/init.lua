-- Neovim Configuration File
-- init.lua
-- Core
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Configs
-- require("config.mason") -- Disabled for instant startup
-- require("config.transparent")
require("config.colorscheme")
require("config.devicons")
require("config.lualine")
require("config.gitsigns")
require("config.treesitter")
require("config.namu")
require("config.telescope")
require("config.cmp")
-- require("config.lspconfig") -- Disabled for instant startup
require("config.noice")
require("config.autopairs")
require("config.conform")
require("config.trouble")
require("config.snacks")
require("config.multicursor")
require("config.oil")
require("config.btw")

-- LSP (Local & Fast)
require("lsp").setup()
