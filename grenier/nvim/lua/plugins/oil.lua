local oil_ok, oil = pcall(require, "oil")
if oil_ok then
  local git_ok, oil_git = pcall(require, "oil-git")
  if git_ok then
    oil_git.setup({
      show_ignored_files = true,
      show_ignored_directories = true,
      symbol_position = "right_align",
      symbols = {
        file = { added = "", modified = "", renamed = "", deleted = "", copied = "", conflict = "", untracked = "", ignored = "" },
        directory = { added = "", modified = "", renamed = "", deleted = "", copied = "", conflict = "", untracked = "", ignored = "" },
      },
      highlights = {
        OilGitAdded = { link = "diffAdded" },
        OilGitModified = { link = "diffChanged" },
        OilGitRenamed = { link = "diffLine" },
        OilGitUntracked = { link = "Comment" },
        OilGitIgnored = { fg = "#777777" },
        OilGitDeleted = { link = "diffRemoved" },
        OilGitConflict = { link = "diffRemoved" },
        OilGitCopied = { link = "diffAdded" },
      },
    })
  end
  oil.setup({
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    columns = { "icon" },
    keymaps = {
      ["<CR>"] = "actions.select",
      ["<2-LeftMouse>"] = "actions.select",
      ["<C-s>"] = false, ["<C-h>"] = false, ["<M-h>"] = "actions.select_split",
      ["<C-l>"] = false, ["<C-c>"] = false,
      ["R"] = "actions.refresh",
      ["<Esc>"] = "actions.close", ["q"] = "actions.close",
      ["<leader>cd"] = "actions.cd",
    },
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr)
        local hidden = { [".DS_Store"] = true, [".git"] = true, ["node_modules"] = true }
        return hidden[name]
      end,
    },
    win_options = { winbar = " " },
  })
end
