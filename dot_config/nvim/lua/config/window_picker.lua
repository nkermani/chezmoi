local ok, picker = pcall(require, "window-picker")
if not ok then return end

picker.setup({
    hint = 'floating-big-letter',
    show_prompt = false,
    filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        bo = {
            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
            buftype = { 'terminal', "quickfix" },
        },
    },
    highlights = {
        statusline = {
            focused = {
                fg = '#212121',
                bg = '#00f0ff',
                bold = true,
            },
            unfocused = {
                fg = '#212121',
                bg = '#ffcc00',
                bold = true,
            },
        },
    },
})

vim.keymap.set("n", "<leader>wp", function()
    local window_number = picker.pick_window()
    if window_number then
        vim.api.nvim_set_current_win(window_number)
    end
end, { desc = "Window Picker" })
