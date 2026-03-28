-- lua/core/keymaps/modern.lua
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- MACOS "COMMAND" SHORTCUTS
keymap({ 'n', 'i', 'v' }, '<D-s>', '<cmd>w<CR>', { desc = "Save File" })
keymap('v', '<D-c>', '"+y', { desc = "Copy" })
keymap('n', '<D-c>', '"+yy', { desc = "Copy Line" })
keymap('i', '<D-c>', '<Esc>"+yygi', { desc = "Copy Line" })
keymap('n', '<D-v>', '"+p', { desc = "Paste" })
keymap('i', '<D-v>', '<C-r>+', { desc = "Paste" })
keymap('v', '<D-v>', '"+P', { desc = "Paste" })
keymap('v', '<D-x>', '"+d', { desc = "Cut" })
keymap('n', '<D-x>', '"+dd', { desc = "Cut Line" })
keymap('i', '<D-x>', '<Esc>"+ddgi', { desc = "Cut Line" })
keymap('n', '<D-z>', 'u', { desc = "Undo" })
keymap('i', '<D-z>', '<C-o>u', { desc = "Undo" })
keymap('v', '<D-z>', '<Esc>ugv', { desc = "Undo" })
keymap({ 'n', 'v', 'i' }, '<D-a>', '<Esc>ggVG', { desc = "Select All" })

-- COPIER / COUPER / COLLER (CTRL + C/X/V)
keymap('n', '<C-c>', '"+yy', { desc = "Copy line" })
keymap('i', '<C-c>', '<Esc>"+yygi', { desc = "Copy line" })
keymap('v', '<C-c>', '"+y', { desc = "Copy selection" })
keymap('n', '<C-x>', '"+dd', { desc = "Cut line" })
keymap('i', '<C-x>', '<Esc>"+ddgi', { desc = "Cut line" })
keymap('v', '<C-x>', '"+d', { desc = "Cut selection" })
keymap('n', '<C-v>', '"+p', { desc = "Paste" })
keymap('i', '<C-v>', '<C-r>+', { desc = "Paste" })
keymap('v', '<C-v>', '"+P', { desc = "Paste without overwrite" })

-- Copier/Couper vers le registre système explicitement
keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- SAUVEGARDE RAPIDE (CTRL + S)
keymap('n', '<C-s>', '<cmd>w<CR>', { desc = "Save File" })
keymap('i', '<C-s>', '<Esc><cmd>w<CR>gi', { desc = "Save File" })
keymap('v', '<C-s>', '<Esc><cmd>w<CR>gv', { desc = "Save File" })

-- MOUSE EXPERIENCE (Style IDE)
-- CTRL + Clic Gauche : Aller à la définition
keymap("n", "<C-LeftMouse>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
keymap("n", "<C-M-LeftMouse>", function()
    require('telescope.builtin').lsp_references({
        layout_strategy = 'cursor',
        layout_config = {
            width = 0.6,
            height = 0.4,
        },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    })
end, { desc = "Peek references" })
keymap('n', '<2-LeftMouse>', 'viw', opts)
-- Triple-clic : Sélectionne toute la ligne
keymap('n', '<3-LeftMouse>', 'V', opts)

-- Raccourci pour fermer les fenêtres flottantes en mode Insertion
keymap("i", "q", function()
    local winid = vim.api.nvim_get_current_win()
    local cfg = vim.api.nvim_win_get_config(winid)
    if cfg.relative ~= "" then
        vim.api.nvim_win_close(winid, false)
    else
        vim.api.nvim_feedkeys("q", "n", false)
    end
end, { desc = "Close floating window in insert mode" })

-- Menu contextuel (Clic droit)
vim.cmd([[
  amenu PopUp.Split\ Vertical <cmd>vsplit<CR>
  amenu PopUp.Split\ Horizontal <cmd>split<CR>
  amenu PopUp.Kill\ Buffer <cmd>lua _G.smart_close()<CR>
  amenu PopUp.Add\ to\ Multi-Selection <Plug>(VM-Visual-Cursors)
  amenu PopUp.Copy\ (Multi) y
  amenu PopUp.Quit\ Neovim <cmd>qa<CR>
  amenu PopUp.-1- *
  amenu PopUp.Definition <cmd>lua vim.lsp.buf.definition()<CR>
  amenu PopUp.References <cmd>lua require('telescope.builtin').lsp_references({ layout_strategy = 'cursor', layout_config = { width = 0.6, height = 0.4 } })<CR>
  amenu PopUp.Rename <cmd>lua vim.lsp.buf.rename()<CR>
  amenu PopUp.-2- *
  amenu PopUp.Format <cmd>lua vim.lsp.buf.format()<CR>
]])
