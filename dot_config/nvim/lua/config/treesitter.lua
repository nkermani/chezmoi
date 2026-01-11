-- lua/config/treesitter.lua
local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then
    return
end

configs.setup({
    ensure_installed = { 'c', 'lua', 'python', 'markdown', 'rust' },
    highlight = { enable = true },
})

-- Spécifique 42
local install = require('nvim-treesitter.install')
install.compilers = { 'clang', 'gcc' }
