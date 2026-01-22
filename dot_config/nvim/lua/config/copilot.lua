-- lua/config/copilot.lua

-- lua/config/copilot.lua
require('copilot').setup({
  suggestion = {
    enabled = false,  -- TRUE TO WORK
    auto_trigger = false, -- TRUE TO WORK
    keymap = {
      -- On met à false ici pour gérer le Tab manuellement ci-dessous
      accept = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
})

-- Configuration du Tab Intelligent
-- vim.keymap.set('i', '<Tab>', function()
--   if require("copilot.suggestion").is_visible() then
--     require("copilot.suggestion").accept()
--   else
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
--   end
-- end, { desc = "Super Tab for Copilot" })

