-- lua/config/mason.lua
-- mason-org/mason.nvim -> Allows to install LSP servers for nvim-lspconfig to work

local ok, mason = pcall(require, "mason")
if not ok then return end

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then return end

require("mason").setup()
require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls",}
    }
)
