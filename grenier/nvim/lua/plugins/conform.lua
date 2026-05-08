vim.g.disable_autoformat = true
local ok, conform = pcall(require, "conform")
if ok then
  conform.setup({
    formatters_by_ft = {
      lua = {},
      python = { "isort", "black" },
      c = { "clang-format" },
      rust = { "rustfmt" },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    notify_on_error = false,
  })
end
