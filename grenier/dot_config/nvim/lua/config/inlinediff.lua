local status_ok, inlinediff = pcall(require, "inlinediff")
if not status_ok then
    return
end

inlinediff.setup({
    colors = {
        InlineDiffAddContext = "#2d4a2d",
        InlineDiffAddChange = "#57f246",
        InlineDiffDeleteContext = "#4a2d2d",
        InlineDiffDeleteChange = "#ff0055",
    }
})

vim.api.nvim_set_hl(0, "InlineDiffAddContext", { bg = "#2d4a2d", force = true })
vim.api.nvim_set_hl(0, "InlineDiffAddChange", { fg = "#000000", bg = "#57f246", bold = true, force = true })
vim.api.nvim_set_hl(0, "InlineDiffDeleteContext", { bg = "#4a2d2d", force = true })
vim.api.nvim_set_hl(0, "InlineDiffDeleteChange", { fg = "#ffffff", bg = "#ff0055", bold = true, force = true })

local function toggle_inline_diff()
    local buf = vim.api.nvim_get_current_buf()
    
    vim.cmd("InlineDiff")
    
    local is_enabled = require("inlinediff").enabled
    
    local msg = is_enabled and "Inline Diff: ON" or "Inline Diff: OFF"
    local level = is_enabled and vim.log.levels.INFO or vim.log.levels.WARN
    
    vim.notify(msg, level, { title = "InlineDiff" })
end

vim.keymap.set("n", "<leader>id", toggle_inline_diff, { desc = "Toggle Inline Diff" })
