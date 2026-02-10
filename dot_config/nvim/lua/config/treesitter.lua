-- lua/config/treesitter.lua
-- nvim-treesitter/nvim-treesitter -> functions for installing, updating, and removing tree-sitter parsers;
--                                 -> a collection of queries for enabling tree-sitter features built into Neovim for these languages;
--                                 -> a staging ground for treesitter-based features considered for upstreaming to Neovim.

local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then
    return
end

configs.setup({
    ensure_installed = { 'c', 'lua', 'python', 'markdown', 'rust' },
    highlight = { enable = true },
    indent = { enable = false },
})

-- Spécifique 42
local install = require('nvim-treesitter.install')
install.compilers = { 'clang', 'gcc' }
