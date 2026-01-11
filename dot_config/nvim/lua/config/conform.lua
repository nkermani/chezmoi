-- lua/config/conform.lua
require("conform").setup({
    formatters_by_ft = {
        lua = {},  -- stylua disabled, will use LSP fallback
        python = { "isort", "black" },
        c = { "clang-format" },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
})
