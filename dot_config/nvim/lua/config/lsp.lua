-- lua/config/lsp.lua
local lspconfig = require("lspconfig")

-- Utilisation de pcall (protected call) pour vérifier si Mason est présent
local status_ok, mason = pcall(require, "mason")
if not status_ok then
    print("Mason n'est pas encore installé. Lancez la commande d'installation de votre pack manager.")
    return
end

local mlsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlsp_ok then return end

-- Si on arrive ici, on peut configurer
mason.setup()
mason_lspconfig.setup({
    ensure_installed = { "clangd", "lua_ls", "bashls", "pyright", "ts_ls" }
})

-- 1. Initialiser Mason (Gestionnaire d'installation)
mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- 2. Liste des serveurs à installer
mason_lspconfig.setup({
    ensure_installed = {
        "clangd",    -- C
        "lua_ls",    -- Lua
        "bashls",    -- Shell
        "pyright",   -- Python
        "ts_ls",     -- JS/TS
    }
})

-- 3. Intégration avec nvim-cmp (pour les suggestions)
local capabilities = vim.lsp.protocol.make_client_capabilities()
if pcall(require, "cmp_nvim_lsp") then
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end

-- 4. Configuration des serveurs
mason_lspconfig.setup_handlers({
    -- Configuration par défaut pour tous les serveurs
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = capabilities,
        })
    end,

    -- Configuration spécifique pour Lua
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }, -- Supprime l'avertissement 'undefined global vim'
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                },
            },
        })
    end,
})

-- 5. Amélioration visuelle des diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

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

