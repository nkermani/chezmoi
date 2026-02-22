-- lua/core/keymaps/editing.lua
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- INDENTATION (TAB / SHIFT+TAB)
keymap("v", "<Tab>", ">gv", { desc = "Indent selection" })
keymap("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })
keymap("n", "<Tab>", ">>", { desc = "Indent line" })
keymap("n", "<S-Tab>", "<<", { desc = "Unindent line" })
keymap("i", "<S-Tab>", "<C-d>", { desc = "Unindent line" })

-- DÉPLACER des lignes (Alt + Up/Down)
keymap('n', '<M-Down>', function() if vim.bo.modifiable then vim.cmd('m .+1') vim.cmd('normal! ==') end end, opts)
keymap('n', '<M-Up>', function() if vim.bo.modifiable then vim.cmd('m .-2') vim.cmd('normal! ==') end end, opts)
keymap('i', '<M-Down>', function() if vim.bo.modifiable then vim.cmd('normal! <Esc>') vim.cmd('m .+1') vim.cmd('normal! ==gi') end end, opts)
keymap('i', '<M-Up>', function() if vim.bo.modifiable then vim.cmd('normal! <Esc>') vim.cmd('m .-2') vim.cmd('normal! ==gi') end end, opts)
keymap('v', '<M-Down>', function() if vim.bo.modifiable then vim.cmd("m '>+1") vim.cmd('normal! gv=gv') end end, opts)
keymap('v', '<M-Up>', function() if vim.bo.modifiable then vim.cmd("m '<-2") vim.cmd('normal! gv=gv') end end, opts)

-- DUPLIQUER des lignes (Shift + Alt + Up/Down)
keymap('n', '<S-M-Down>', function() if vim.bo.modifiable then vim.cmd('normal! yyp') end end, opts)
keymap('n', '<S-M-Up>', function() if vim.bo.modifiable then vim.cmd('normal! yyP') end end, opts)
keymap('i', '<S-M-Down>', function() if vim.bo.modifiable then vim.cmd('normal! <Esc>yypgi') end end, opts)
keymap('i', '<S-M-Up>', function() if vim.bo.modifiable then vim.cmd('normal! <Esc>yyPgi') end end, opts)
keymap('v', '<S-M-Down>', function() if vim.bo.modifiable then vim.cmd('normal! yPgv') end end, opts)
keymap('v', '<S-M-Up>', function() if vim.bo.modifiable then vim.cmd('normal! yPgv') end end, opts)

-- SUPPRESSION RAPIDE
keymap('i', '<M-BS>', '<C-u>', { desc = "Delete to start of line" })
keymap('n', '<M-BS>', function() if vim.bo.modifiable then vim.cmd('normal! d^') end end, { desc = "Delete to start of line" })
keymap('i', '<M-Delete>', '<C-o>D', { desc = "Delete to end of line" })
keymap('n', '<M-Delete>', function() if vim.bo.modifiable then vim.cmd('normal! D') end end, { desc = "Delete to end of line" })

-- SUPPRESSION MOT ENTIER (CTRL + Backspace / Delete)
keymap('i', '<C-BS>', '<C-w>', opts)
keymap('i', '<M-BS>', '<C-w>', opts)
keymap('i', '<C-H>', '<C-w>', opts)
keymap('n', '<C-BS>', function() if vim.bo.modifiable then vim.cmd('normal! db') end end, opts)
keymap('n', '<C-H>', function() if vim.bo.modifiable then vim.cmd('normal! db') end end, opts)
keymap('v', '<C-BS>', '"_d', opts)
keymap('v', '<C-H>', '"_d', opts)
keymap("n", "<C-Delete>", function() if vim.bo.modifiable then vim.cmd('normal! dw') end end, { desc = "Delete word forward" })
keymap("i", "<C-Delete>", "<C-o>dw", { desc = "Delete word forward in insert mode" })

-- Comportement Backspace / Delete / Enter style "Éditeur moderne"
keymap('n', '<BS>', function()
    if not vim.bo.modifiable then
        vim.cmd('normal! h')
        return
    end
    if vim.fn.col('.') == 1 then
        if vim.fn.line('.') > 1 then
            vim.cmd('normal! kgJ')
        end
    else
        vim.cmd('normal! x')
    end
end, { desc = "Backspace: Join with previous line or delete character" })

keymap('n', '<Del>', function()
    if not vim.bo.modifiable then
        return
    end
    local line = vim.fn.getline('.')
    if #line == 0 or vim.fn.col('.') >= #line then
        vim.cmd('normal! gJ')
    else
        vim.cmd('normal! x')
    end
end, { desc = "Delete: Join with next line or delete character" })

keymap('n', '<CR>', function()
    if not vim.bo.modifiable then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
        return
    end
    vim.cmd('normal! i\13\27')
end, { desc = "Enter splits line" })

-- COMMENTAIRES (CTRL + /)
keymap('n', '<C-_>', 'gcc', { remap = true, desc = "Comment line" })
keymap('n', '<C-/>', 'gcc', { remap = true, desc = "Comment line" })
keymap('i', '<C-_>', '<Esc>gccai', { remap = true, desc = "Comment line" })
keymap('i', '<C-/>', '<Esc>gccai', { remap = true, desc = "Comment line" })
keymap('v', '<C-_>', 'gc', { remap = true, desc = "Comment selection" })
keymap('v', '<C-/>', 'gc', { remap = true, desc = "Comment selection" })

-- UNDO / REDO
keymap("n", "<C-z>", "u", { desc = "Undo" })
keymap("n", "<C-y>", "<C-r>", { desc = "Redo" })
keymap("i", "<C-z>", "<C-o>u", { desc = "Undo" })
keymap("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })
keymap("v", "<C-z>", "<Esc>ugv", { desc = "Undo" })
keymap("v", "<C-y>", "<Esc><C-r>gv", { desc = "Redo" })

-- SUPPRESSION SANS ÉCRASER LE PRESSE-PAPIER
keymap({ "n", "v" }, "x", '"_x', opts)
keymap({ "n", "v" }, "d", '"_d', opts)
keymap({ "n", "v" }, "D", '"_D', opts)
keymap({ "n", "v" }, "c", '"_c', opts)
keymap({ "n", "v" }, "C", '"_C', opts)
keymap("v", "<BS>", '"_d', opts)

-- Garde le contenu du presse-papier après avoir collé sur une sélection
keymap("x", "p", function()
    if vim.bo.modifiable then
        vim.cmd('normal! "_dP')
    else
        vim.cmd('normal! y')
    end
end, { desc = "Paste without overwriting register" })
