local status_ok, outline = pcall(require, "outline")
if not status_ok then
    return
end

outline.setup({
    outline_window = {
        position = 'right',
        width = 25,
        relative_width = true,
        auto_close = false,
        auto_jump = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_cursorline = true,
        hide_cursor = false,
        focus_on_open = true,
        winhl = "",
    },
    outline_items = {
        show_symbol_lineno = false,
    },
})
