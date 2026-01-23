-- lua/config/trouble.lua
-- folke/trouble.nvim -> A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.

local trouble = require("trouble")
trouble.setup()
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
