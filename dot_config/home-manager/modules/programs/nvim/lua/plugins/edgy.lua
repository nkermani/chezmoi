local ok, edgy = pcall(require, "edgy")
if ok then
  edgy.setup({
    left = {
      { title = "Neo-Tree", ft = "neo-tree" },
    },
    bottom = {
      { title = "Trouble", ft = "trouble" },
      { title = "Telescope", ft = "Telescope" },
    },
    keys = {
      ["<leader>a"] = function() require("edgy").toggle() end,
    },
    animate = { enabled = false },
    exit_on_last = false,
    win_options = { winhighlight = "Normal:Normal,NormalNC:NormalNC,WinSeparator:WinSeparator" },
  })
end
