local nvchad_repo = "https://github.com/NvChad/NvChad"

local lazypath = vim.fn.stdpath("data") .. "/lazy/nvchad"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--depth", "1", nvchad_repo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("nvchad.bootstrap")

vim.defer_fn(function()
  require("nvchad.config"):load()
end, 50)
