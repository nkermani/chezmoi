local M = {}

M.general = {
  n = {
    ["<C-d>"] = { "<C-d>zz", "Scroll down center" },
    ["<C-u>"] = { "<C-u>zz", "Scroll up center" },
    ["n"] = { "nzzzv", "Next result center" },
    ["N"] = { "Nzzzv", "Prev result center" },
    ["<leader>w"] = { ":w<CR>", "Save file" },
    ["<leader>q"] = { ":q<CR>", "Quit" },
    ["<leader>h"] = { ":nohlsearch<CR>", "Clear search" },
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "Move line down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move line up" },
  },
  i = {
    ["<C-j>"] = { "<esc>", "Escape insert mode" },
  },
}

M.telescope = {
  n = {
    ["<leader>,"] = { "<cmd> Telescope <CR>", "Open telescope" },
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fg"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
  },
}

M.lspconfig = {
  n = {
    ["gd"] = { "<cmd> lua vim.lsp.buf.definition()<CR>", "Go to definition" },
    ["gD"] = { "<cmd> lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
    ["gi"] = { "<cmd> lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
    ["gr"] = { "<cmd> lua vim.lsp.buf.references()<CR>", "Go to references" },
    ["<leader>rn"] = { "<cmd> lua vim.lsp.buf.rename()<CR>", "Rename" },
    ["<leader>d"] = { "<cmd> lua vim.diagnostic.open_float()<CR>", "Show diagnostics" },
  },
}

return M
