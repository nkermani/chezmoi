-- lua/config/conform.lua
-- stevearc/conform.nvim -> Lightweight yet powerful formatter plugin for Neovim

vim.g.disable_autoformat = true

require("conform").setup({
    formatters_by_ft = {
        lua = {},
        python = { "isort", "black" },
        c = { "clang-format" },
        rust = { "rustfmt" },
    },
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { timeout_ms = 500, lsp_fallback = true }
    end,
    notify_on_error = false,
})

vim.keymap.set("n", "<leader>tf", function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    local status = vim.g.disable_autoformat and "OFF" or "ON"
    vim.notify("Format on Save " .. status, vim.log.levels.INFO, { title = "Conform" })
end, { desc = "Toggle Format on Save" })
