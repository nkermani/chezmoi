local status_ok, codediff = pcall(require, "codediff")
if not status_ok then
    return
end

codediff.setup({
    view_type = "tab",
    keymaps = {
        view = {
            open_in_prev_tab = "<CR>",
        }
    }
})

vim.keymap.set("n", "<leader>df", "<cmd>CodeDiff<cr>", { desc = "Open VSCode-style Diff" })
