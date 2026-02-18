-- lua/core/keymaps.lua
-- Keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- DÉSACTIVER le scroll par défaut de CTRL+D pour laisser multicursor l'utiliser
vim.keymap.set({ 'n', 'v', 'i' }, '<C-d>', '<nop>', { noremap = false })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-u>', '<nop>', { noremap = false })

local chars = { ',', '.', '!', '?', ';', ' ', '(', ')', '[', ']', '{', '}' }
for _, char in ipairs(chars) do
    keymap('i', char, char .. '<c-g>u', { noremap = true, silent = true })
end

-- Désactive la suspension de Neovim avec CTRL+Z
vim.keymap.set({ 'n', 'v', 'i' }, '<C-z>', '<nop>')
vim.keymap.set({ 'n', 'v', 'i' }, '<C-S-z>', '<nop>')

-- Command Palette
keymap({ 'n', 'v', 'i' }, "<C-p>", ":Telescope commands<CR>", { desc = "Command Palette" })
keymap({ 'n', 'v', 'i' }, "<C-S-p>", ":Telescope commands<CR>", { desc = "Command Palette" })

-- Navigation rapide entre les splits avec Ctrl + hjkl
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- ===================================================================
-- SELECTION SHORTCUTS
-- ===================================================================

local function wrap_selection(open, close)
    return function()
        local mode = vim.fn.mode()
        local save_reg = vim.fn.getreg('v')
        local save_regtype = vim.fn.getregtype('v')

        vim.cmd('normal! "vy')
        local text = vim.fn.getreg('v')

        if mode == 'V' then
            text = open .. text:gsub('\n$', '') .. close .. '\n'
        else
            text = open .. text .. close
        end

        vim.fn.setreg('v', text)
        vim.cmd('normal! gv"vp')
        vim.cmd('normal! `[v`]')

        vim.fn.setreg('v', save_reg, save_regtype)
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.keymap.set("x", "[", wrap_selection("[", "]"), { buffer = true, nowait = true, desc = "Wrap with []" })
    end,
})

local function jump_to_bracket(target)
    return function()
        local start_pos = vim.api.nvim_win_get_cursor(0)
        local pattern = target == "open" and "[{(]" or "[})]"
        local flags = target == "open" and "bW" or "W"

        local search_pos = vim.fn.searchpos(pattern, flags .. 'n')

        if target == "open" then
            vim.cmd("silent! normal! [{")
            vim.cmd("silent! normal! [(")
        else
            vim.cmd("silent! normal! ]}")
            vim.cmd("silent! normal! ])")
        end
        local unmatched_pos = vim.api.nvim_win_get_cursor(0)

        if search_pos[1] ~= 0 then
            if unmatched_pos[1] == start_pos[1] and unmatched_pos[2] == start_pos[2] then
                vim.fn.cursor(search_pos[1], search_pos[2])
            else
                local dist_unmatched = math.abs(unmatched_pos[1] - start_pos[1])
                local dist_search = math.abs(search_pos[1] - start_pos[1])
                if dist_search < dist_unmatched then
                    vim.fn.cursor(search_pos[1], search_pos[2])
                end
            end
        end
    end
end

keymap({ "n", "x" }, "<leader>[", jump_to_bracket("open"), { desc = "Jump to opening bracket" })
keymap({ "n", "x" }, "<leader>]", jump_to_bracket("close"), { desc = "Jump to closing bracket" })

keymap("x", "(", wrap_selection("(", ")"), { desc = "Wrap with ()", nowait = true })
keymap("x", "{", wrap_selection("{", "}"), { desc = "Wrap with {}", nowait = true })
keymap("x", '"', wrap_selection('"', '"'), { desc = 'Wrap with ""', nowait = true })
keymap("x", "'", wrap_selection("'", "'"), { desc = "Wrap with ''", nowait = true })
keymap("x", "`", wrap_selection("`", "`"), { desc = "Wrap with ``", nowait = true })

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

-- Ajouter une ligne vide en dessous (Shift + Entrée)
keymap("n", "<S-Enter>", "o<Esc>", { desc = "Insert blank line below" })

keymap("n", "<C-S-Left>", "vb", { desc = "Select Word Left" })
keymap("n", "<C-S-Right>", "vw", { desc = "Select Word Right" })
keymap("v", "<C-S-Left>", "b", { desc = "Extend Word Left" })
keymap("v", "<C-S-Right>", "w", { desc = "Extend Word Right" })
keymap("i", "<C-S-Left>", "<Esc>vb", { desc = "Select Word Left" })
keymap("i", "<C-S-Right>", "<Esc>vw", { desc = "Select Word Right" })

-- ALT + SHIFT + ARROWS (Select Extremities)
keymap("n", "<M-S-Left>", "v^", { desc = "Select to Start of Line" })
keymap("n", "<M-S-Right>", "v$", { desc = "Select to End of Line" })
keymap("v", "<M-S-Left>", "^", { desc = "Extend to Start of Line" })
keymap("v", "<M-S-Right>", "$", { desc = "Extend to End of Line" })
keymap("i", "<M-S-Left>", "<Esc>v^", { desc = "Select to Start of Line" })
keymap("i", "<M-S-Right>", "<Esc>v$", { desc = "Select to End of Line" })

-- Raccourcis plus intuitifs pour split (ex: leader + | ou -)
keymap("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split vertical" })
keymap("n", "<leader>-", "<cmd>split<cr>", { desc = "Split horizontal" })

-- Recherche de texte dans tout le projet (Live Grep)
keymap("n", "fw", ":Telescope live_grep<CR>", { desc = "Search text in project" })

-- Recherche dans le fichier courant avec CTRL+F
keymap("n", "<C-f>", "/", { desc = "Search" })
keymap("v", "<C-f>", [[y/<C-r>"<CR>]], { desc = "Search visual selection" })
keymap("i", "<C-f>", "<ESC>/", { desc = "Search from Insert" })

-- Si tu veux vraiment un raccourci proche de VSCode (CTRL+Maj+F)
keymap("n", "<C-S-f>", ":Telescope live_grep<CR>", { desc = "Search text in project" })

-- Raccourci pour INSTALLER (ne le faire que si tu ajoutes un plugin)
vim.keymap.set('n', '<leader>pi', function()
    dofile(vim.fn.stdpath("config") .. "/lua/plugins.lua")
    vim.notify("Vérification des plugins en cours...", vim.log.levels.INFO)
end, { desc = "Plugins Install/Check" })

-- Raccourci pour synchroniser vers START après l'install
vim.keymap.set('n', '<leader>ps', ':!./sync_plugins.sh<CR>', { desc = "Sync Plugins to Start" })

-- Garde le contenu du presse-papier après avoir collé sur une sélection
keymap("x", "p", [["_dP]])

-- Copier/Couper vers le registre système explicitement
keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
keymap("n", "<Esc>", "<cmd>noh<cr><Esc>", { desc = "Clear search highlights" })

-- Toggle les numéros de ligne
vim.keymap.set('n', '<leader>nl', function()
    vim.opt.number = not vim.opt.number:get()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle Line Numbers" })

-- ===================================================================
-- INDENTATION (TAB / SHIFT+TAB)
-- ===================================================================
keymap("v", "<Tab>", ">gv", { desc = "Indent selection" })
keymap("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })
keymap("n", "<Tab>", ">>", { desc = "Indent line" })
keymap("n", "<S-Tab>", "<<", { desc = "Unindent line" })
keymap("i", "<S-Tab>", "<C-d>", { desc = "Unindent line" })

-- ===================================================================
-- NAVIGATION DÉBUT/FIN DE LIGNE (HOME/END)
-- ===================================================================
keymap('n', '<M-Left>', '^', opts)
keymap('n', '<M-Right>', '$', opts)
keymap('n', '<Home>', '^', opts)
keymap('n', '<End>', '$', opts)
keymap('i', '<M-Left>', '<C-o>^', opts)
keymap('i', '<M-Right>', '<C-o>$', opts)
keymap('i', '<Home>', '<C-o>^', opts)
keymap('i', '<End>', '<C-o>$', opts)
keymap('v', '<M-Left>', '^', opts)
keymap('v', '<M-Right>', '$', opts)
keymap('v', '<Home>', '^', opts)
keymap('v', '<End>', '$', opts)

-- 2. MOT PAR MOT (CTRL + Flèches)
keymap({ 'n', 'v' }, '<C-Left>', 'b', opts)
keymap({ 'n', 'v' }, '<C-Right>', 'w', opts)
keymap('i', '<C-Left>', '<C-o>b', opts)
keymap('i', '<C-Right>', '<C-o>w', opts)

-- 3. SÉLECTION MOT PAR MOT (CTRL + SHIFT + Flèches)
keymap('n', '<C-S-Left>', 'vb', opts)
keymap('n', '<C-S-Right>', 'vw', opts)
keymap('i', '<C-S-Left>', '<Esc>vb', opts)
keymap('i', '<C-S-Right>', '<Esc>vw', opts)
keymap('v', '<C-S-Left>', 'b', opts)
keymap('v', '<C-S-Right>', 'w', opts)

-- 4. SUPPRESSION MOT ENTIER (CTRL + Backspace)
keymap('i', '<C-BS>', '<C-w>', opts)
keymap('i', '<M-BS>', '<C-w>', opts)
keymap('i', '<C-H>', '<C-w>', opts)
keymap('n', '<C-BS>', 'db', opts)
keymap('n', '<C-H>', 'db', opts)
keymap('v', '<C-BS>', '"_d', opts)
keymap('v', '<C-H>', '"_d', opts)

-- Comportement Backspace / Delete / Enter style "Éditeur moderne"
keymap('n', '<BS>', function()
    if vim.fn.col('.') == 1 then
        if vim.fn.line('.') > 1 then
            vim.cmd('normal! kgJ')
        end
    else
        vim.cmd('normal! x')
    end
end, { desc = "Backspace: Join with previous line or delete character" })

keymap('n', '<Del>', function()
    local line = vim.fn.getline('.')
    if #line == 0 or vim.fn.col('.') >= #line then
        vim.cmd('normal! gJ')
    else
        vim.cmd('normal! x')
    end
end, { desc = "Delete: Join with next line or delete character" })

keymap('n', '<CR>', 'i<CR><Esc>', { desc = "Enter splits line" })

-- CTRL + Delete pour supprimer le mot suivant
keymap("n", "<C-Delete>", "dw", { desc = "Delete word forward" })
keymap("i", "<C-Delete>", "<C-o>dw", { desc = "Delete word forward in insert mode" })

-- VISUAL BLOCK MODE
keymap('n', '<leader>v', '<C-v>', { desc = "Visual Block Mode" })

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

-- SUPPRESSION RAPIDE
keymap('i', '<M-BS>', '<C-u>', { desc = "Delete to start of line" })
keymap('n', '<M-BS>', 'd^', { desc = "Delete to start of line" })
keymap('i', '<M-Delete>', '<C-o>D', { desc = "Delete to end of line" })
keymap('n', '<M-Delete>', 'D', { desc = "Delete to end of line" })

-- DÉPLACER des lignes (Alt + J/K)
keymap('n', '<M-Down>', ':m .+1<CR>==', opts)
keymap('n', '<M-Up>', ':m .-2<CR>==', opts)
keymap('i', '<M-Down>', '<Esc>:m .+1<CR>==gi', opts)
keymap('i', '<M-Up>', '<Esc>:m .-2<CR>==gi', opts)
keymap('v', '<M-Down>', ":m '>+1<CR>gv=gv", opts)
keymap('v', '<M-Up>', ":m '<-2<CR>gv=gv", opts)

-- DUPLIQUER des lignes (Shift + Alt + Flèches)
keymap('n', '<S-M-Down>', 'yyp', opts)
keymap('n', '<S-M-Up>', 'yyP', opts)
keymap('i', '<S-M-Down>', '<Esc>yypgi', opts)
keymap('i', '<S-M-Up>', '<Esc>yyPgi', opts)
keymap('v', '<S-M-Down>', "yPgv", opts)
keymap('v', '<S-M-Up>', "yPgv", opts)

-- SÉLECTION TOTALE (CTRL + A)
keymap({ 'n', 'i', 'v' }, '<C-a>', 'ggVG', { desc = "Select All" })

-- SCROLL VERTICAL (ALT + MOLETTE)
keymap({ 'n', 'i', 'v' }, '<M-ScrollWheelDown>', '15<C-e>', opts)
keymap({ 'n', 'i', 'v' }, '<M-ScrollWheelUp>', '15<C-y>', opts)

-- SCROLL HORIZONTAL (SHIFT + MOLETTE)
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

-- DÉSACTIVER L'HISTORIQUE DES COMMANDES
keymap("n", "q:", "<nop>", opts)
keymap("n", "q/", "<nop>", opts)
keymap("n", "q?", "<nop>", opts)
keymap("v", "q:", "<nop>", opts)
keymap("n", "q", "<nop>", opts)

-- SAUVEGARDE RAPIDE (CTRL + S)
keymap('n', '<C-s>', '<cmd>w<CR>', { desc = "Save File" })
keymap('i', '<C-s>', '<Esc><cmd>w<CR>gi', { desc = "Save File" })
keymap('v', '<C-s>', '<Esc><cmd>w<CR>gv', { desc = "Save File" })

keymap({ 'n', 'i', 'v' }, '<C-S-q>', ':q!<CR>', { desc = "Force Quit" })

-- UNDO / REDO
keymap("n", "<C-z>", "u", { desc = "Undo" })
keymap("n", "<C-y>", "<C-r>", { desc = "Redo" })
keymap("i", "<C-z>", "<C-o>u", { desc = "Undo" })
keymap("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })
keymap("v", "<C-z>", "<Esc>ugv", { desc = "Undo" })
keymap("v", "<C-y>", "<Esc><C-r>gv", { desc = "Redo" })

-- SÉLECTION DE LIGNE (CTRL + L)
keymap('n', '<C-l>', 'V', { desc = "Select line" })
keymap('i', '<C-l>', '<Esc>V', { desc = "Select line" })
keymap('v', '<C-l>', 'j', { desc = "Extend selection" })

-- MOUSE EXPERIENCE (Style IDE)
-- CTRL + Clic Gauche : Aller à la définition
keymap("n", "<C-LeftMouse>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
keymap("n", "<C-M-LeftMouse>", "<cmd>Telescope lsp_references<CR>", { desc = "Show references" })
keymap('n', '<2-LeftMouse>', 'viw', opts)
-- Triple-clic : Sélectionne toute la ligne
keymap('n', '<3-LeftMouse>', 'V', opts)

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
  amenu PopUp.References <cmd>Telescope lsp_references<CR>
  amenu PopUp.Rename <cmd>lua vim.lsp.buf.rename()<CR>
  amenu PopUp.-2- *
  amenu PopUp.Format <cmd>lua vim.lsp.buf.format()<CR>
]])

-- BUFFERLINE (TABS) NAVIGATION
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })
keymap({ "n", "i", "v" }, "<M-w>", function() _G.smart_close() end, { desc = "Smart Close (Pane or Buffer)" })
keymap("n", "<leader>x", function() _G.smart_close() end, { desc = "Smart Close (Pane or Buffer)" })

keymap("n", "<leader>tp", function()
    local ok, precognition = pcall(require, "precognition")
    if ok then
        precognition.toggle()
        local status = precognition.is_visible() and "ON" or "OFF"
        vim.notify("Precognition " .. status, vim.log.levels.INFO, { title = "Precognition" })
    end
end, { desc = "Toggle Precognition" })

keymap("n", "<leader>td", function()
    local is_enabled = vim.diagnostic.is_enabled()
    vim.diagnostic.enable(not is_enabled)
    local status = is_enabled and "OFF" or "ON"
    vim.notify("Diagnostics " .. status, vim.log.levels.INFO, { title = "LSP Diagnostics" })
end, { desc = "Toggle Diagnostics" })

