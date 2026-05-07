---@type vim.lsp.Config
return {
    cmd = { 'pylsp' },
    filetypes = { 'python' },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        '.git',
    },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.root(bufnr, {
            'pyproject.toml',
            'setup.py',
            'setup.cfg',
            'requirements.txt',
            'Pipfile',
            '.git',
        })
        on_dir(root or vim.fs.dirname(fname) or vim.uv.cwd())
    end,
    settings = {
        pylsp = {
            plugins = {
                jedi_completion = {
                    enabled = true,
                    include_params = true,
                    include_class_objects = true,
                    include_function_objects = true,
                    eager = true,
                    fuzzy = true,
                    resolve_at_most = 50,
                    cache_for = { "pandas", "numpy", "tensorflow", "matplotlib", "scipy" },
                },
                rope_autoimport = { enabled = true },
                rope_completion = { enabled = true, eager = true },
                pycodestyle = { enabled = false },
                pylint = { enabled = false },
            }
        }
    },
}
