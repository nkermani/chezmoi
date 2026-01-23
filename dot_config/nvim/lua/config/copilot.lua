-- lua/config/copilot.lua
local status_ok, copilot = pcall(require, "copilot")
if not status_ok then return end

copilot.setup({
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

