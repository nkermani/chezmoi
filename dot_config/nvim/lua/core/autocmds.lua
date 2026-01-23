-- lua/core/autocmds.lua
-- You can specify commands to be executed automatically when reading or writing

local autocmd = vim.api.nvim_create_autocmd

-- Surligner brièvement le texte lors d'un "yank" (copie)
autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Supprimer les espaces blancs en fin de ligne au moment de sauvegarder
autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
