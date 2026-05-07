local ok, configs = pcall(require, 'nvim-treesitter.configs')
if ok then
  configs.setup({
    ensure_installed = { 'c', 'lua', 'python', 'markdown', 'rust' },
    highlight = { enable = true },
  })
  local install = require('nvim-treesitter.install')
  install.compilers = { 'clang', 'gcc' }
end
