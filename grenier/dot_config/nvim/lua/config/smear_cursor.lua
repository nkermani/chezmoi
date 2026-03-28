local status_ok, smear_cursor = pcall(require, "smear_cursor")
if not status_ok then return end

smear_cursor.setup({
    cursor_color = "#00f0ff",
    stiffness = 0.6,
    trailing_stiffness = 0.3,
    distance_stop_animating = 0.1,
    hide_target_cursor = false,
})
