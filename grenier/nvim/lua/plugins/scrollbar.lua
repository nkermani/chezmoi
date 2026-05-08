local ok, scrollbar = pcall(require, "scrollbar")
if ok then
  scrollbar.setup({
    show = true, zindex = 100,
    handle = { text = " ", blend = 0 },
    excluded_filetypes = { "neo-tree", "TelescopePrompt", "noice", "alpha", "toggleterm" },
  })
end
