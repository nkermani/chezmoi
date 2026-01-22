-- lua/config/trouble.lua

local trouble = require("trouble")

trouble.setup()

-- Ouvrir la liste des diagnostics du projet
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")

-- Diagnostics du fichier actuel uniquement
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")

-- Liste de recherche (Location list)
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>")

-- Liste de Quickfix
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>")

