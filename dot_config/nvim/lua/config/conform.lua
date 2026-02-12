-- lua/config/conform.lua
-- stevearc/conform.nvim -> Lightweight yet powerful formatter plugin for Neovim

require("conform").setup({
    formatters_by_ft = {
        lua = {},  -- stylua disabled, will use LSP fallback
        python = { "isort", "black" },
        c = { "clang-format" },
        rust = { "rustfmt" },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
})
