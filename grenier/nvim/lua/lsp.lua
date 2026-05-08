-- ====== LSP ======
local lsp_ok, lsp = pcall(require, "lsp")
if lsp_ok then
  lsp.setup({})
end

-- ====== AUTO-REQUIRE CHECK ======
local chars = { ',', '.', '!', '?', ';', ' ', '(', ')', '[', ']', '{', '}' }
for _, char in ipairs(chars) do
  vim.keymap.set('i', char, char .. '<c-g>u', { noremap = true, silent = true })
end

-- ====== LSP KEYMAPS ======
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
