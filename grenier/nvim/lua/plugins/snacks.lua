local ok, snacks = pcall(require, "snacks")
if ok then
  snacks.setup({
    notifier = { enabled = true, timeout = 3000 },
    bigfile = { enabled = true },
    scroll = { enabled = true },
    indent = { enabled = true, char = "│", scope = { enabled = true, char = "│" } },
    zen = {
      enabled = true, minimal = false,
      toggles = { dim = false, git = false, diagnostics = true },
      show = { statusline = true, tabline = true },
      win = { width = 0.85, height = 0.85, border = "rounded", backdrop = { transparent = false, opacity = 100 }, winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder" },
    },
  })
end
