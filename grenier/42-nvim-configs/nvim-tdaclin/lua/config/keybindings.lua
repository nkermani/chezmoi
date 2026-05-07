
vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "kj", "<esc>")

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })

vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<cr>")

vim.keymap.set("n", "<leader>cj", function() vim.diagnostic.jump({ count = 1 }) end)
vim.keymap.set("n", "<leader>ck", function() vim.diagnostic.jump({ count = -1}) end)
vim.keymap.set("n", "<leader>cd", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>co", vim.diagnostic.open_float)


