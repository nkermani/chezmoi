local ok, telescope = pcall(require, "telescope")
if ok then
  telescope.setup({
    defaults = {
      mappings = { i = { ["<C-u>"] = false } },
      file_ignore_patterns = { "node_modules", ".git/", ".cache", "Downloads/", "Documents/42/utils/", ".pdf", ".tar.gz" },
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
        vertical = { mirror = false },
        width = 0.87, height = 0.80, preview_cutoff = 120,
      },
      prompt_position = "top",
      path_display = { "truncate" },
      winblend = 0,
      border = true,
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" },
    },
  })
end
vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "FloatBorder" })
