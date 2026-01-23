-- lua/lsp/init.lua

local M = {}

function M.setup()
    -- Configuration native minimaliste pour les LSP
    -- Pas de mason, pas de lspconfig, juste vim.lsp.start

    -- 1. Lua Language Server
    -- Vérifie si la commande existe dans le PATH
    if vim.fn.executable('lua-language-server') == 1 then
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'lua',
            callback = function(args)
                vim.lsp.start({
                    name = 'lua_ls',
                    cmd = { 'lua-language-server' },
                    root_dir = vim.fs.dirname(vim.fs.find({'.git', '.luarc.json'}, { upward = true })[1]) or vim.loop.cwd(),
                    settings = {
                        Lua = {
                            diagnostics = { globals = { 'vim' } },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false, 
                                maxPreload = 1000,
                                preloadFileSize = 1000,
                            },
                            telemetry = { enable = false },
                        },
                    },
                })
            end,
        })
    end

    -- 2. Rust Analyzer
    if vim.fn.executable('rust-analyzer') == 1 then
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'rust',
            callback = function(args)
                vim.lsp.start({
                    name = 'rust-analyzer',
                    cmd = { 'rust-analyzer' },
                    root_dir = vim.fs.dirname(vim.fs.find({'Cargo.toml'}, { upward = true })[1]) or vim.loop.cwd(),
                })
            end,
        })
    end

    -- 3. Clangd (C/C++)
    if vim.fn.executable('clangd') == 1 then
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'c', 'cpp', 'objc', 'objcpp' },
            callback = function(args)
                vim.lsp.start({
                    name = 'clangd',
                    cmd = { 'clangd' },
                    root_dir = vim.fs.dirname(vim.fs.find({'.git', 'compile_commands.json'}, { upward = true })[1]) or vim.loop.cwd(),
                })
            end,
        })
    end
    
    -- Configurer l'apparence des diagnostics (erreurs, warnings)
    vim.diagnostic.config({
        float = { border = "rounded" },
        virtual_text = true,
        signs = true,
    })
    
    -- Mappings natifs (légers)
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local opts = { buffer = args.buf }
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        end,
    })
end

return M
