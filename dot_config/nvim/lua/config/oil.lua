-- lua/config/oil.lua
-- stevearc/oil.nvim -> A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer
local ok, oil = pcall(require, "oil")
if not ok then return end

require("oil").setup({
    keymaps = {
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
        ["<C-l>"] = false,                 -- Release Ctrl+L for global "Select Line" map
        ["<C-s>"] = false,                 -- Release Ctrl+S for global "Save" map (Commit changes)
        ["<C-c>"] = false,                 -- Release Ctrl+C for global "Copy" map (Close oil is normally default)
        ["R"] = "actions.refresh",         -- Shift+R to refresh
        ["<leader>r"] = "actions.refresh", -- Leader+r to refresh
    },
    view_options = {
        show_hidden = true,
    },
})

-- Fonction générique pour changer de répertoire
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
