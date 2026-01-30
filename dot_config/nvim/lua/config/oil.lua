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

    require('telescope.builtin').find_files({
        prompt_title = open_oil and "Change Directory & Open Oil" or "Change Directory",
        cwd = os.getenv("HOME"),
        find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git", "--exclude", "Library" },
        previewer = false,
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            map('i', '<CR>', function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection then
                    vim.cmd("cd " .. selection.path)
                    print("Changed directory to: " .. selection.path)
                    if open_oil then
                        require("oil").open(selection.path)
                    end
                end
            end)
            return true
        end
    })
end

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "_", "<CMD>Oil .<CR>", { desc = "Open Oil in CWD" })
vim.keymap.set("n", "<leader>cd", function() change_directory({ open_oil = false }) end, { desc = "Change directory" })
vim.keymap.set("n", "<leader>co", function() change_directory({ open_oil = true }) end,
    { desc = "Change dir and open Oil" })
