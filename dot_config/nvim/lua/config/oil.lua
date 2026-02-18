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
            OilGitAdded = { fg = "#51f66f", bold = true },
            OilGitModified = { fg = "#eedb85", bold = true },
            OilGitRenamed = { fg = "#00f0ff", bold = true },
            OilGitUntracked = { fg = "#368aec", bold = true },
            OilGitIgnored = { fg = "#777777" },
            OilGitDeleted = { fg = "#f3505c", bold = true },
            OilGitConflict = { fg = "#f3505c", bold = true },
            OilGitCopied = { fg = "#51f66f", bold = true },
        }
    })
end


require("oil").setup({
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    columns = {
        "icon",
    },
    keymaps = {
        ["<CR>"] = "actions.select",
        ["<2-LeftMouse>"] = "actions.select",
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
        ["<C-l>"] = false,
        ["<C-c>"] = false,
        ["R"] = "actions.refresh",
        ["<Esc>"] = "actions.close",
        ["q"] = "actions.close",
        ["<leader>cd"] = "actions.cd",
        ["<C-t>"] = {
            callback = function()
                local dir = require("oil").get_current_dir()
                local status, tt = pcall(require, "toggleterm")
                if status then
                    tt.toggle(nil, nil, dir)
                end
            end,
            desc = "Toggle Terminal in current directory",
        },
    },
    view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
            local hidden = { [".DS_Store"] = true, [".git"] = true, ["node_modules"] = true }
            return hidden[name]
        end,
    },
    win_options = {
        winbar = " ",
    },
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

vim.keymap.set("n", "-", function()
    if vim.bo.filetype == "oil" then
        require("oil").open("..")
    else
        local nt_api = pcall(require, "neo-tree.command")
        if nt_api then
            require("neo-tree.command").execute({ action = "close" })
        end
        vim.cmd("Oil")
    end
end, { desc = "Go up in Oil or Open Oil (closing Neo-tree)" })
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
