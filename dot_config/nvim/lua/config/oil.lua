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
    },
    view_options = {
        show_hidden = false,
        is_hidden_file = function(name, bufnr)
            local hidden = { [".DS_Store"] = true, [".git"] = true, ["node_modules"] = true }
            return hidden[name] or vim.startswith(name, ".")
        end,
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "_", "<CMD>Oil .<CR>", { desc = "Open Oil in CWD" })
