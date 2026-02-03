local status_ok, copilot = pcall(require, "copilot")
if not status_ok then return end

copilot.setup({
    copilot_node_command = vim.fn.expand("$HOME/.nkermani/apps/nvm/versions/node/v22.22.0/bin/node"),
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
            accept = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
        },
    },
    panel = { enabled = false },
})

vim.keymap.set('i', '<Tab>', function()
    local suggestion = require("copilot.suggestion")
    if suggestion.is_visible() then
        suggestion.accept()
    else
        return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
    end
end, { expr = true, silent = true, desc = "Copilot Smart Tab" })

vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#555555", italic = true })

local copilot_enabled = true
vim.keymap.set('n', '<leader>ct', function()
    require("copilot.suggestion").toggle_auto_trigger()
    copilot_enabled = not copilot_enabled
    vim.notify("Copilot autocompletion " .. (copilot_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end, { desc = "Toggle Copilot autocompletion" })
