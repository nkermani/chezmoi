local ok, oil = pcall(require, "oil")
if not ok then return end

local git_ok, oil_git = pcall(require, "oil-git")
if git_ok then
    oil_git.setup({
        show_ignored_files = true,
        show_ignored_directories = true,
        symbol_position = "right_align",
        symbols = {
            file = {
                added = "",
                modified = "",
                renamed = "",
                deleted = "",
                copied = "",
                conflict = "",
                untracked = "",
                ignored = "",
            },
            directory = {
                added = "",
                modified = "",
                renamed = "",
                deleted = "",
                copied = "",
                conflict = "",
                untracked = "",
                ignored = "",
            },
        },
        highlights = {
            OilGitAdded = { fg = "#81b88b", bold = true },
            OilGitModified = { fg = "#e2c08d", bold = true },
            OilGitRenamed = { fg = "#73c991", bold = true },
            OilGitUntracked = { fg = "#d7ba7d", bold = true },
            OilGitIgnored = { fg = "#6a737d" },
            OilGitDeleted = { fg = "#c74e39", bold = true },
            OilGitConflict = { fg = "#e4676b", bold = true },
            OilGitCopied = { fg = "#73c991", bold = true },
        }
    })
end


require("oil").setup({
    columns = {
        "icon",
    },
    keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
        ["<C-l>"] = false,
        ["<C-c>"] = false,
        ["R"] = "actions.refresh",
        ["<Esc>"] = "actions.close",
    },
    view_options = {
        show_hidden = false,
        is_hidden_file = function(name, bufnr)
            local hidden = { [".DS_Store"] = true, [".git"] = true, ["node_modules"] = true }
            return hidden[name] or vim.startswith(name, ".")
        end,
    },
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("OilAutoCd", { clear = true }),
    pattern = "oil://*",
    callback = function()
        local dir = require("oil").get_current_dir()
        if dir then
            pcall(vim.api.nvim_set_current_dir, dir)
        end
    end,
})

local function change_directory(opts)
    opts = opts or {}
    local open_oil = opts.open_oil or false
    local search_cwd = opts.cwd or os.getenv("HOME")
    local prompt = opts.prompt_title or (open_oil and "Change Directory & Open Oil" or "Change Directory")

    require('telescope.builtin').find_files({
        prompt_title = prompt,
        cwd = search_cwd,
        find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git", "--exclude", "Library" },
        previewer = false,
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            map('i', '<CR>', function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection then
                    local path = selection.path or selection[1]
                    local full_path = path
                    if not (path:sub(1, 1) == "/" or path:sub(1, 1) == "~") then
                        full_path = search_cwd .. "/" .. path
                    end
                    full_path = vim.fn.fnamemodify(full_path, ":p")

                    vim.cmd("cd " .. vim.fn.fnameescape(full_path))
                    vim.notify("Changed directory to: " .. full_path, vim.log.levels.INFO)
                    if open_oil then
                        require("oil").open(full_path)
                    end
                end
            end)
            return true
        end
    })
end

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "_", "<CMD>Oil .<CR>", { desc = "Open Oil in CWD" })

vim.keymap.set("n", "<leader>gd", function()
    change_directory({
        open_oil = false,
        cwd = os.getenv("HOME"),
        prompt_title = "📂 Global Change Directory (HOME)"
    })
end, { desc = "Change directory (HOME)" })

vim.keymap.set("n", "<leader>cd", function()
    change_directory({
        open_oil = false,
        cwd = vim.fn.getcwd(),
        prompt_title = "📂 Local Change Directory (CWD)"
    })
end, { desc = "Change directory (CWD)" })

vim.keymap.set("n", "<leader>co", function()
    change_directory({
        open_oil = true,
        cwd = os.getenv("HOME"),
        prompt_title = "📂 Change Dir & Open Oil"
    })
end, { desc = "Change dir and open Oil" })
