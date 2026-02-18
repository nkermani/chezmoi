-- lua/lsp/init.lua

local M = {}

M.pycodestyle_enabled = false

function M.setup()
    -- 1. Lua Language Server
    if vim.fn.executable('lua-language-server') == 1 then
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'lua',
            callback = function(args)
                vim.lsp.start({
                    name = 'lua_ls',
                    cmd = { 'lua-language-server' },
                    root_dir = vim.fs.dirname(vim.fs.find({'.git', '.luarc.json'}, { upward = true })[1]) or vim.uv.cwd(),
                    capabilities = require('cmp_nvim_lsp').default_capabilities(),
                    settings = {
                        Lua = {
                            diagnostics = { globals = { 'vim' } },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false, 
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
                    root_dir = vim.fs.dirname(vim.fs.find({'Cargo.toml'}, { upward = true })[1]) or vim.uv.cwd(),
                    capabilities = require('cmp_nvim_lsp').default_capabilities(),
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
                    root_dir = vim.fs.dirname(vim.fs.find({'.git', 'compile_commands.json'}, { upward = true })[1]) or vim.uv.cwd(),
                    capabilities = require('cmp_nvim_lsp').default_capabilities(),
                })
            end,
        })
    end

    -- 4. Pylsp (Python)
    if vim.fn.executable('pylsp') == 1 then
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'python',
            group = vim.api.nvim_create_augroup('LspPylsp', { clear = true }),
            callback = function(args)
                vim.lsp.start({
                    name = 'pylsp',
                    cmd = { 'pylsp' },
                    root_dir = vim.fs.dirname(vim.fs.find({'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git'}, { upward = true })[1]) or vim.uv.cwd(),
                    capabilities = require('cmp_nvim_lsp').default_capabilities(),
                    settings = {
                        pylsp = {
                            plugins = {
                                jedi_completion = {
                                    enabled = true,
                                    include_params = true,
                                    eager = false,
                                    resolve_at_most = 15,
                                    fuzzy = false,
                                },
                                rope_autoimport = { enabled = false },
                                rope_completion = { enabled = false },
                                pyflakes = { enabled = true },
                                pycodestyle = { enabled = M.pycodestyle_enabled },
                                pylint = { enabled = false },
                                mccabe = { enabled = false },
                            }
                        }
                    },
                })
            end,
        })
    end
    
    vim.diagnostic.config({
        float = { border = "rounded" },
        virtual_text = true,
        signs = true,
    })
    
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

function M.toggle_pycodestyle()
    M.pycodestyle_enabled = not M.pycodestyle_enabled
    for _, client in ipairs(vim.lsp.get_clients({ name = 'pylsp' })) do
        client.settings.pylsp.plugins.pycodestyle.enabled = M.pycodestyle_enabled
        client.rpc.notify('workspace/didChangeConfiguration', { settings = client.settings })
    end
    vim.notify('pycodestyle: ' .. (M.pycodestyle_enabled and 'ON' or 'OFF'), vim.log.levels.INFO)
end

vim.keymap.set('n', '<leader>ty', function() require('lsp').toggle_pycodestyle() end, { desc = "Toggle pycodestyle" })

return M
