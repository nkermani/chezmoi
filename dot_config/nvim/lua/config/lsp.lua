-- lua/config/lsp.lua

-- Utilisation de la nouvelle API de la v0.12
-- Cela configure automatiquement rust-analyzer s'il est dans ton PATH
if vim.fn.executable('rust-analyzer') == 1 then
    vim.lsp.enable('rust-analyzer')
end

-- Configuration des diagnostics (nouveautés v0.10+)
vim.diagnostic.config({
    float = { border = "rounded" },
    virtual_text = true,
    signs = true,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Mappings LSP natifs (plus besoin de plugins pour ça)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Goto Definition" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover Docs" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })

