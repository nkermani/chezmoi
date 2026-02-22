---@diagnostic disable: undefined-global
-- [[ --------------------- KEYMAP OVERVIEW --------------------- ]]
--
-- Leader key: "," (comma)
--
-- ---------------------------------------------------------------
--  General Editor & Text
-- ---------------------------------------------------------------
--   <S-Arrows>   (n,v,i) : Select/Extend characters/lines
--   <C-Arrows>   (n,v,i) : Word movement (Left/Right)
--   <C-S-Arrows> (n,v,i) : Word selection (Left/Right)
--   <M-Arrows>   (n,v,i) : Line start/end (Left/Right)
--   <Home/End>   (n,v,i) : Line start/end
--   <Tab/S-Tab>  (n,v,i) : Indent/Unindent
--   <C-c/x/v>    (n,v,i) : Clipboard (Copy/Cut/Paste)
--   <D-s/c/v/x/z/a>(n,v,i): macOS shortcuts (Save/Copy/Paste/Cut/Undo/SelectAll)
--   <C-z/y>      (n,v,i) : Undo/Redo
--   <C-BS/H/Del> (n,v,i) : Word deletion (Back/Forward)
--   <BS/Del/CR>  (n)     : Modern editor behavior (Join/Split lines)
--   <M-Up/Down>  (n,v,i) : Move lines
--   <S-M-Up/Down>(n,v,i) : Duplicate lines
--   <C-a>        (n,v,i) : Select All
--   <C-s>        (n,v,i) : Save File
--   <C-S-q>      (n,v,i) : Force Quit
--   <M/S-Scroll> (n,v,i) : Vertical/Horizontal scrolling
--   <C-/_>       (n,v,i) : Comments (Toggle)
--   x, d, D, c, C(n,v)   : Blackhole register (Delete without yank)
--   <leader>y/Y  (n,v)   : Yank to system clipboard
--   <S-Enter>    (n)     : Insert blank line below
--
-- [[ ----------------------------------------------------------- ]]
-- lua/core/keymaps/editor.lua
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- SHIFT + ARROWS (Select Characters/Lines)
keymap("n", "<S-Up>", "v<Up>", { desc = "Select Up" })
keymap("n", "<S-Down>", "v<Down>", { desc = "Select Down" })
keymap("n", "<S-Left>", "v<Left>", { desc = "Select Left" })
keymap("n", "<S-Right>", "v<Right>", { desc = "Select Right" })

keymap("v", "<S-Up>", "<Up>", { desc = "Extend Up" })
keymap("v", "<S-Down>", "<Down>", { desc = "Extend Down" })
keymap("v", "<S-Left>", "<Left>", { desc = "Extend Left" })
keymap("v", "<S-Right>", "<Right>", { desc = "Extend Right" })

keymap("i", "<S-Up>", "<Esc>v<Up>", { desc = "Select Up" })
keymap("i", "<S-Down>", "<Esc>v<Down>", { desc = "Select Down" })
keymap("i", "<S-Left>", "<Esc>v<Left>", { desc = "Select Left" })
keymap("i", "<S-Right>", "<Esc>v<Right>", { desc = "Select Right" })

-- ALT + SHIFT + ARROWS (Select Extremities)
keymap("n", "<M-S-Left>", "v^", { desc = "Select to Start of Line" })
keymap("n", "<M-S-Right>", "v$", { desc = "Select to End of Line" })
keymap("v", "<M-S-Left>", "^", { desc = "Extend to Start of Line" })
keymap("v", "<M-S-Right>", "$", { desc = "Extend to End of Line" })
keymap("i", "<M-S-Left>", "<Esc>v^", { desc = "Select to Start of Line" })
keymap("i", "<M-S-Right>", "<Esc>v$", { desc = "Select to End of Line" })

-- MOT PAR MOT (CTRL + Flèches)
keymap({ 'n', 'v' }, '<C-Left>', 'b', opts)
keymap({ 'n', 'v' }, '<C-Right>', 'w', opts)
keymap('i', '<C-Left>', '<C-o>b', opts)
keymap('i', '<C-Right>', '<C-o>w', opts)

-- SÉLECTION MOT PAR MOT (CTRL + SHIFT + Flèches)
keymap('n', '<C-S-Left>', 'vb', opts)
keymap('n', '<C-S-Right>', 'vw', opts)
keymap('i', '<C-S-Left>', '<Esc>vb', opts)
keymap('i', '<C-S-Right>', '<Esc>vw', opts)
keymap('v', '<C-S-Left>', 'b', opts)
keymap('v', '<C-S-Right>', 'w', opts)

-- NAVIGATION DÉBUT/FIN DE LIGNE (HOME/END / ALT+Left/Right)
keymap({ 'n', 'v' }, '<M-Left>', '^', opts)
keymap({ 'n', 'v' }, '<M-Right>', '$', opts)
keymap({ 'n', 'v' }, '<Home>', '^', opts)
keymap({ 'n', 'v' }, '<End>', '$', opts)
keymap('i', '<M-Left>', '<C-o>^', opts)
keymap('i', '<M-Right>', '<C-o>$', opts)
keymap('i', '<Home>', '<C-o>^', opts)
keymap('i', '<End>', '<C-o>$', opts)

-- INDENTATION (TAB / SHIFT+TAB)
keymap("v", "<Tab>", ">gv", { desc = "Indent selection" })
keymap("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })
keymap("n", "<Tab>", ">>", { desc = "Indent line" })
keymap("n", "<S-Tab>", "<<", { desc = "Unindent line" })
keymap("i", "<S-Tab>", "<C-d>", { desc = "Unindent line" })

-- CLIPBOARD (CTRL + C/X/V)
keymap('n', '<C-c>', '"+yy', { desc = "Copy line" })
keymap('i', '<C-c>', '<Esc>"+yygi', { desc = "Copy line" })
keymap('v', '<C-c>', '"+y', { desc = "Copy selection" })
keymap('n', '<C-x>', '"+dd', { desc = "Cut line" })
keymap('i', '<C-x>', '<Esc>"+ddgi', { desc = "Cut line" })
keymap('v', '<C-x>', '"+d', { desc = "Cut selection" })
keymap('n', '<C-v>', '"+p', { desc = "Paste" })
keymap('i', '<C-v>', '<C-r>+', { desc = "Paste" })
keymap('v', '<C-v>', '"+P', { desc = "Paste without overwrite" })

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

-- UNDO / REDO
keymap("n", "<C-z>", "u", { desc = "Undo" })
keymap("n", "<C-y>", "<C-r>", { desc = "Redo" })
keymap("i", "<C-z>", "<C-o>u", { desc = "Undo" })
keymap("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })
keymap("v", "<C-z>", "<Esc>ugv", { desc = "Undo" })
keymap("v", "<C-y>", "<Esc><C-r>gv", { desc = "Redo" })

-- SUPPRESSION RAPIDE
keymap('i', '<C-BS>', '<C-w>', opts)
keymap('i', '<M-BS>', '<C-w>', opts)
keymap('i', '<C-H>', '<C-w>', opts)
keymap('n', '<C-BS>', function() if vim.bo.modifiable then vim.cmd('normal! db') end end, opts)
keymap('n', '<C-H>', function() if vim.bo.modifiable then vim.cmd('normal! db') end end, opts)
keymap('v', '<C-BS>', '"_d', opts)
keymap('v', '<C-H>', '"_d', opts)

keymap("n", "<C-Delete>", function() if vim.bo.modifiable then vim.cmd('normal! dw') end end, { desc = "Delete word forward" })
keymap("i", "<C-Delete>", "<C-o>dw", { desc = "Delete word forward in insert mode" })

keymap('i', '<M-BS>', '<C-u>', { desc = "Delete to start of line" })
keymap('n', '<M-BS>', function() if vim.bo.modifiable then vim.cmd('normal! d^') end end, { desc = "Delete to start of line" })
keymap('i', '<M-Delete>', '<C-o>D', { desc = "Delete to end of line" })
keymap('n', '<M-Delete>', function() if vim.bo.modifiable then vim.cmd('normal! D') end end, { desc = "Delete to end of line" })

-- BACKSPACE / DELETE / ENTER (Modern Style)
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

-- AUTRES
keymap({ 'n', 'i', 'v' }, '<C-a>', 'ggVG', { desc = "Select All" })
keymap('n', '<C-s>', '<cmd>w<CR>', { desc = "Save File" })
keymap('i', '<C-s>', '<Esc><cmd>w<CR>gi', { desc = "Save File" })
keymap('v', '<C-s>', '<Esc><cmd>w<CR>gv', { desc = "Save File" })
keymap({ 'n', 'i', 'v' }, '<C-S-q>', ':q!<CR>', { desc = "Force Quit" })

-- SCROLL
keymap({ 'n', 'i', 'v' }, '<M-ScrollWheelDown>', '15<C-e>', opts)
keymap({ 'n', 'i', 'v' }, '<M-ScrollWheelUp>', '15<C-y>', opts)
keymap({ 'n', 'i', 'v' }, '<S-ScrollWheelDown>', '5zh', opts)
keymap({ 'n', 'i', 'v' }, '<S-ScrollWheelUp>', '5zl', opts)

-- COMMENTAIRES (CTRL + /)
keymap('n', '<C-_>', 'gcc', { remap = true, desc = "Comment line" })
keymap('n', '<C-/>', 'gcc', { remap = true, desc = "Comment line" })
keymap('i', '<C-_>', '<Esc>gccai', { remap = true, desc = "Comment line" })
keymap('i', '<C-/>', '<Esc>gccai', { remap = true, desc = "Comment line" })
keymap('v', '<C-_>', 'gc', { remap = true, desc = "Comment selection" })
keymap('v', '<C-/>', 'gc', { remap = true, desc = "Comment selection" })

-- SUPPRESSION SANS ÉCRASER LE PRESSE-PAPIER
keymap({ "n", "v" }, "x", '"_x', opts)
keymap({ "n", "v" }, "d", '"_d', opts)
keymap({ "n", "v" }, "D", '"_D', opts)
keymap({ "n", "v" }, "c", '"_c', opts)
keymap({ "n", "v" }, "C", '"_C', opts)
keymap("v", "<BS>", '"_d', opts)
keymap("x", "p", [["_dP]])

-- YANK TO SYSTEM CLIPBOARD
keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Ajouter une ligne vide en dessous (Shift + Entrée)
keymap("n", "<S-Enter>", "o<Esc>", { desc = "Insert blank line below" })
