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

-- Changer de fenêtre (split) avec CTRL + Flèches
-- NOTE: Les raccourcis CTRL+Left/Right sont réassignés plus bas pour le saut de mots.
-- keymap("n", "<C-Left>", "<C-w>h", { desc = "Fenêtre de gauche" })
-- keymap("n", "<C-Down>", "<C-w>j", { desc = "Fenêtre du bas" })
-- keymap("n", "<C-Up>", "<C-w>k", { desc = "Fenêtre du haut" })
-- keymap("n", "<C-Right>", "<C-w>l", { desc = "Fenêtre de droite" })

-- Navigation rapide entre les splits avec Ctrl + hjkl
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- ===================================================================
-- SELECTION SHORTCUTS
-- ===================================================================

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

-- CTRL + SHIFT + ARROWS (Select Word/Line)
-- Note: Left/Right are also mapped lower down (around line 160)
keymap("n", "<C-S-Up>", "v<Up>", { desc = "Select Line Up" })
keymap("n", "<C-S-Down>", "v<Down>", { desc = "Select Line Down" })
keymap("v", "<C-S-Up>", "<Up>", { desc = "Extend Line Up" })
keymap("v", "<C-S-Down>", "<Down>", { desc = "Extend Line Down" })
keymap("i", "<C-S-Up>", "<Esc>v<Up>", { desc = "Select Line Up" })
keymap("i", "<C-S-Down>", "<Esc>v<Down>", { desc = "Select Line Down" })

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

-- keymap("n", "<M-S-Up>", "vgg", { desc = "Select to Start of File" })
-- keymap("n", "<M-S-Down>", "vG", { desc = "Select to End of File" })
-- keymap("v", "<M-S-Up>", "gg", { desc = "Extend to Start of File" })
-- keymap("v", "<M-S-Down>", "G", { desc = "Extend to End of File" })
-- keymap("i", "<M-S-Up>", "<Esc>vgg", { desc = "Select to Start of File" })
-- keymap("i", "<M-S-Down>", "<Esc>vG", { desc = "Select to End of File" })

-- Redimensionner avec ALT + Flèches
-- keymap("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Augmenter la hauteur" })
-- keymap("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Diminuer la hauteur" })
-- keymap("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Diminuer la largeur" })
-- keymap("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Augmenter la largeur" })

-- Raccourcis plus intuitifs pour split (ex: leader + | ou -)
keymap("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split vertical" })
keymap("n", "<leader>-", "<cmd>split<cr>", { desc = "Split horizontal" })

-- Recherche de texte dans tout le projet (Live Grep)
-- Utilise <leader>fw (Find Word) ou <C-f> selon ta préférence
keymap("n", "fw", ":Telescope live_grep<CR>", { desc = "Search text in project" })

-- Recherche dans le fichier courant avec CTRL+F
keymap("n", "<C-f>", "/", { desc = "Search" })
keymap("v", "<C-f>", [[y/<C-r>"<CR>]], { desc = "Search visual selection" })
keymap("i", "<C-f>", "<ESC>/", { desc = "Search from Insert" })

-- Si tu veux vraiment un raccourci proche de VSCode (CTRL+Maj+F)
keymap("n", "<C-S-f>", ":Telescope live_grep<CR>", { desc = "Search text in project" })

-- Raccourci pour INSTALLER (ne le faire que si tu ajoutes un plugin)
vim.keymap.set('n', '<leader>pi', function()
    -- On ne charge le fichier plugins que ICI, à la demande
    dofile(vim.fn.stdpath("config") .. "/lua/plugins.lua")
    -- print("Vérification des plugins en cours...")
    vim.notify("Vérification des plugins en cours...", vim.log.levels.INFO)
end, { desc = "Plugins Install/Check" })

-- Raccourci pour synchroniser vers START après l'install
vim.keymap.set('n', '<leader>ps', ':!./sync_plugins.sh<CR>', { desc = "Sync Plugins to Start" })

-- Garde le contenu du presse-papier après avoir collé sur une sélection
-- (Évite que le texte remplacé ne vienne écraser ton copier)
keymap("x", "p", [["_dP]])

-- Copier/Couper vers le registre système explicitement (au cas où)
keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
-- Appuyer sur Échap pour enlever la surbrillance de la recherche (hlsearch)
keymap("n", "<Esc>", "<cmd>noh<cr><Esc>", { desc = "Clear search highlights" })

-- Toggle les numéros de ligne (Absolute et Relative)
vim.keymap.set('n', '<leader>nl', function()
    vim.opt.number = not vim.opt.number:get()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle Line Numbers" })

-- ===================================================================
-- INDENTATION (TAB / SHIFT+TAB)
-- ===================================================================
-- Mode Visual : Indenter / Désindenter
keymap("v", "<Tab>", ">gv", { desc = "Indent selection" })
keymap("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })
-- Mode Normal : Indenter / Désindenter
keymap("n", "<Tab>", ">>", { desc = "Indent line" })
keymap("n", "<S-Tab>", "<<", { desc = "Unindent line" })
-- Mode Insertion : Indenter / Désindenter
keymap("i", "<S-Tab>", "<C-d>", { desc = "Unindent line" }) -- <C-d> en insert désindente
-- ===================================================================
-- 1. DÉBUT / FIN DE LIGNE (Home/End & ALT + Flèches)
local directions = {
    { mode = { 'n', 'i', 'v' }, keys = { '<Home>', '<M-Left>' }, target = '^', desc = "Début de ligne" },
    { mode = { 'n', 'i', 'v' }, keys = { '<End>', '<M-Right>' }, target = '$', desc = "Fin de ligne" }
}

for _, map in ipairs(directions) do
    for _, key in ipairs(map.keys) do
        keymap(map.mode[1], key, map.mode[1] == 'i' and ('<C-o>' .. map.target) or map.target, opts)
        keymap(map.mode[2], key, map.target, opts) -- Pour Visual
        if map.mode[3] then keymap(map.mode[3], key, map.target, opts) end
    end
end

-- ===================================================================
-- NAVIGATION DÉBUT/FIN DE LIGNE (HOME/END)
-- ===================================================================

-- Mode NORMAL
keymap('n', '<M-Left>', '^', opts)
keymap('n', '<M-Right>', '$', opts)
keymap('n', '<Home>', '^', opts)
keymap('n', '<End>', '$', opts)

-- Mode INSERTION
-- On utilise <C-o> pour exécuter une commande normale sans quitter l'insert
keymap('i', '<M-Left>', '<C-o>^', opts)
keymap('i', '<M-Right>', '<C-o>$', opts)
keymap('i', '<Home>', '<C-o>^', opts)
keymap('i', '<End>', '<C-o>$', opts)

-- Mode VISUEL
-- En visuel, on veut déplacer le curseur pour étendre la sélection
keymap('v', '<M-Left>', '^', opts)
keymap('v', '<M-Right>', '$', opts)
keymap('v', '<Home>', '^', opts)
keymap('v', '<End>', '$', opts)

-- 2. MOT PAR MOT (CTRL + Flèches / ALT + Flèches)
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

-- 4. SUPPRESSION MOT ENTIER (CTRL + Backspace / ALT + Backspace)
-- Note: Dans certains terminaux CTRL+BS envoie <C-H> ou <C-w>
keymap('i', '<C-BS>', '<C-w>', opts)
keymap('i', '<M-BS>', '<C-w>', opts)
keymap('i', '<C-H>', '<C-w>', opts) -- Pour certains terminaux Linux

keymap('n', '<C-BS>', 'db', opts)
keymap('n', '<C-H>', 'db', opts)
keymap('v', '<C-BS>', '"_d', opts)
keymap('v', '<C-H>', '"_d', opts)

-- keymap('n', '<BS>', 'X', opts)   -- BACKSPACE supprime le caractère précédent (comme DEL en mode normal)

-- Comportement Backspace / Delete / Enter style "Éditeur moderne" en mode Normal

-- Backspace : Efface le caractère précédent, et si début de ligne, joint avec la ligne précédente
keymap('n', '<BS>', function()
    local col = vim.fn.col('.')
    if col == 1 then
        -- Si on est au début de la ligne, on remonte (k) et on joint (gJ)
        local row = vim.fn.line('.')
        if row > 1 then
            vim.cmd('normal! kgJ')
        end
    else
        vim.cmd('normal! X')
    end
end, { desc = "Backspace behaves like Insert mode" })

-- Delete : Efface le caractère sous le curseur. Si ligne vide, la supprime (joint).
keymap('n', '<Del>', function()
    local line_len = #vim.fn.getline('.')
    if line_len == 0 then
        vim.cmd('normal! gJ')
    else
        vim.cmd('normal! x')
    end
end, { desc = "Delete behaves like Insert mode" })

-- Enter : Coupe la ligne à la position du curseur (Smart Split)
-- Utilise i<CR><Esc> pour respecter l'indentation automatique et les hooks
keymap('n', '<CR>', 'i<CR><Esc>', { desc = "Enter splits line" })

-- 5. FORMATAGE & ÉCRAN
keymap('n', '<leader>nl', ':set number!<CR>', { desc = "Toggle Line Numbers" })

-- CTRL + Delete pour supprimer le mot suivant (Mode Normal)
keymap("n", "<C-Delete>", "dw", { desc = "Delete word forward" })
-- CTRL + Delete pour supprimer le mot suivant (Mode Insertion)
-- On passe en mode normal temporairement pour faire 'dw' puis on revient en insertion
keymap("i", "<C-Delete>", "<C-o>dw", { desc = "Delete word forward in insert mode" })
-- ===================================================================
-- VISUAL BLOCK MODE (Alternative à CTRL+V qui est pris par Coller)
-- ===================================================================
keymap('n', '<leader>v', '<C-v>', { desc = "Visual Block Mode" })

-- ===================================================================
-- MACOS "COMMAND" SHORTCUTS (Support expérimental)
-- Nécessite que le terminal envoie les bons codes pour Cmd (D)
-- ===================================================================
-- Sauvegarder (Cmd+S)
keymap({ 'n', 'i', 'v' }, '<D-s>', '<cmd>w<CR>', { desc = "Save File" })

-- Copier (Cmd+C)
keymap('v', '<D-c>', '"+y', { desc = "Copy" })
keymap('n', '<D-c>', '"+yy', { desc = "Copy Line" })
keymap('i', '<D-c>', '<Esc>"+yygi', { desc = "Copy Line" })

-- Coller (Cmd+V)
keymap('n', '<D-v>', '"+p', { desc = "Paste" })
keymap('i', '<D-v>', '<C-r>+', { desc = "Paste" })
keymap('v', '<D-v>', '"+P', { desc = "Paste" })

-- Couper (Cmd+X)
keymap('v', '<D-x>', '"+d', { desc = "Cut" })
keymap('n', '<D-x>', '"+dd', { desc = "Cut Line" })
keymap('i', '<D-x>', '<Esc>"+ddgi', { desc = "Cut Line" })

-- Undo (Cmd+Z)
keymap('n', '<D-z>', 'u', { desc = "Undo" })
keymap('i', '<D-z>', '<C-o>u', { desc = "Undo" })
keymap('v', '<D-z>', '<Esc>ugv', { desc = "Undo" })

-- Tout sélectionner (Cmd+A)
keymap({ 'n', 'v', 'i' }, '<D-a>', '<Esc>ggVG', { desc = "Select All" })

-- ===================================================================
-- OPTIONS COMMUNES POUR LES Raccourcis
-- ==================================================================
-- ==================================================================
-- COPIER VERS LE PRESSE-PAPIER SYSTÈME (CTRL + C)
-- ==================================================================
-- Mode Normal : Copier la ligne courante
keymap('n', '<C-c>', '"+yy', { desc = "Copier la ligne vers le presse-papier système" })
-- Mode Insertion : Copier la ligne courante sans quitter le mode Insertion
keymap('i', '<C-c>', '<Esc>"+yygi', { desc = "Copier la ligne vers le presse-papier système" })
-- Mode Visuel : Copier la sélection vers le presse-papier système
keymap('v', '<C-c>', '"+y', { desc = "Copier la sélection vers le presse-papier système" })

-- ==================================================================
-- COUPER VERS LE PRESSE-PAPIER SYSTÈME (CTRL + X)
-- ==================================================================
-- Mode Normal : Couper la ligne courante
keymap('n', '<C-x>', '"+dd', { desc = "Couper la ligne vers le presse-papier système" })
-- Mode Insertion : Couper la ligne courante sans quitter le mode Insertion
keymap('i', '<C-x>', '<Esc>"+ddgi', { desc = "Couper la ligne vers le presse-papier système" })
-- Mode Visuel : Couper la sélection vers le presse-papier système
keymap('v', '<C-x>', '"+d', { desc = "Couper la sélection vers le presse-papier système" })

-- ===================================================================
-- COLLAGE DEPUIS LE PRESSE-PAPIER SYSTÈME (CTRL + V)
-- ===================================================================
-- Mode Normal : Coller après le curseur
keymap('n', '<C-v>', '"+p', { desc = "Coller depuis le presse-papier système" })
-- Mode Insertion : Coller depuis le presse-papier système sans quitter le mode Insertion
keymap('i', '<C-v>', '<C-r>+', { desc = "Coller depuis le presse-papier système" })
-- Mode Visuel : Remplacer la sélection par le contenu du presse-papier système
-- Utilise "P" au lieu de "p" en visuel pour NE PAS écraser le registre avec le texte supprimé
keymap('v', '<C-v>', '"+P', { desc = "Coller depuis le presse-papier système sans écraser" })

-- ===================================================================
-- SUPPRESSION RAPIDE (Début/Fin de ligne)
-- ===================================================================

-- ALT + Backspace : Supprimer jusqu'au DÉBUT de la ligne
-- En mode Insertion
keymap('i', '<M-BS>', '<C-u>', { desc = "Supprimer jusqu'au début de ligne" })
-- En mode Normal
keymap('n', '<M-BS>', 'd^', { desc = "Supprimer jusqu'au début de ligne" })

-- ALT + Delete : Supprimer jusqu'à la FIN de la ligne
-- En mode Insertion
keymap('i', '<M-Delete>', '<C-o>D', { desc = "Supprimer jusqu'à la fin de ligne" })
-- En mode Normal
keymap('n', '<M-Delete>', 'D', { desc = "Supprimer jusqu'à la fin de ligne" })

-- DÉPLACER des lignes (Alt + J/K ou Alt + Flèches)
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

-- ===================================================================
-- SÉLECTION TOTALE (CTRL + A)
-- ===================================================================

-- Mode Normal : Sélectionne tout et passe en mode Visuel
keymap('n', '<C-a>', 'ggVG', { desc = "Sélectionner tout" })

-- Mode Insertion : Sort, sélectionne tout et reste en mode Visuel
keymap('i', '<C-a>', '<Esc>ggVG', { desc = "Sélectionner tout" })

-- Mode Visuel : Étend la sélection à tout le document
keymap('v', '<C-a>', '<Esc>ggVG', { desc = "Sélectionner tout" })

-- ===================================================================
-- SCROLL VERTICAL (ALT + MOLETTE)
-- ===================================================================
keymap({ 'n', 'i', 'v' }, '<M-ScrollWheelDown>', '15<C-e>', opts)
keymap({ 'n', 'i', 'v' }, '<M-ScrollWheelUp>', '15<C-y>', opts)

-- ===================================================================
-- SCROLL HORIZONTAL (SHIFT + MOLETTE)
-- ===================================================================

-- Scroll vers le bas plus vite (5 lignes par cran)
keymap({ 'n', 'i', 'v' }, '<S-ScrollWheelDown>', '5zh', opts)
keymap({ 'n', 'i', 'v' }, '<S-2-ScrollWheelDown>', '5zh', opts) -- Gère le double-clic de molette

-- Scroll vers le haut plus vite (5 lignes par cran)
keymap({ 'n', 'i', 'v' }, '<S-ScrollWheelUp>', '5zl', opts)
keymap({ 'n', 'i', 'v' }, '<S-2-ScrollWheelUp>', '5zl', opts)

-- ===================================================================
-- DOUBLE-CLIC : SÉLECTION + MODE INSERTION AU DÉBUT
-- ===================================================================
-- Double-clic gauche : Sélectionne le mot et place le curseur au début en mode insert
keymap('n', '<2-LeftMouse>', 'viw<Esc>i', opts)
-- Si tu es déjà en mode Visuel, un double-clic te place au début du mot en insert
keymap('v', '<2-LeftMouse>', '<Esc>bi', opts)
-- Triple-clic : Sélectionne toute la ligne et passe en mode insert
keymap('n', '<3-LeftMouse>', 'V<Esc>i', opts)

-- ===================================================================
-- COMMENTAIRES (CTRL + /)
-- ===================================================================

-- Mode Normal : Commente la ligne actuelle
keymap('n', '<C-_>', 'gcc', { remap = true, desc = "Comment line" })
keymap('n', '<C-/>', 'gcc', { remap = true, desc = "Comment line" })

-- Mode Insertion : Commente et reste en mode insertion
keymap('i', '<C-_>', '<Esc>gccai', { remap = true, desc = "Comment line" })
keymap('i', '<C-/>', '<Esc>gccai', { remap = true, desc = "Comment line" })

-- Mode Visuel : Commente tout le bloc sélectionné
keymap('v', '<C-_>', 'gc', { remap = true, desc = "Comment selection" })
keymap('v', '<C-/>', 'gc', { remap = true, desc = "Comment selection" })

-- ===================================================================
-- SUPPRESSION SANS ÉCRASER LE PRESSE-PAPIER (Blackhole Register)
-- ===================================================================

-- Supprimer un caractère (x)
keymap({ "n", "v" }, "x", '"_x', opts)

-- Supprimer (d, dd, D)
keymap({ "n", "v" }, "d", '"_d', opts)
keymap({ "n", "v" }, "D", '"_D', opts)

-- Supprimer et insérer (c, C) - Optionnel mais souvent souhaité
keymap({ "n", "v" }, "c", '"_c', opts)
keymap({ "n", "v" }, "C", '"_C', opts)

-- Backspace pour supprimer la sélection (Visual Block, etc.)
keymap("v", "<BS>", '"_d', opts)

-- ===================================================================
-- DÉSACTIVER L'HISTORIQUE DES COMMANDES (q: / q?)
-- ===================================================================

-- Désactive l'ouverture de la fenêtre d'historique avec q:
keymap("n", "q:", "<nop>", opts)
-- Désactive l'ouverture de la fenêtre d'historique de recherche avec q/ ou q?
keymap("n", "q/", "<nop>", opts)
keymap("n", "q?", "<nop>", opts)

-- On désactive aussi en mode visuel pour éviter les erreurs
keymap("v", "q:", "<nop>", opts)
keymap("n", "q", "<nop>", opts)

-- ===================================================================
-- SAUVEGARDE RAPIDE (CTRL + S)
-- ===================================================================
--
-- Mode normal : Sauvegarde le fichier courant
keymap('n', '<C-s>', ':w<CR>', { desc = "Sauvegarder le fichier" })
-- Mode insertion : Sauvegarde le fichier courant sans quitter le mode Insertion
-- On utilise <C-o> pour exécuter une commande normale sans quitter l'insert
keymap('i', '<C-s>', '<C-o>:w<CR>', { desc = "Sauvegarder le fichier" })
-- Mode visuel : Sauvegarde le fichier courant et reste en mode Visuel
keymap('v', '<C-s>', '<Esc>:w<CR>gv', { desc = "Sauvegarder le fichier" })
-- ===================================================================
-- ===================================================================
-- QUITTER NEOVIM (CTRL + Q)
-- ===================================================================
-- Mode normal : Quitte NEOVIM
-- On utilise :q! pour forcer la fermeture sans sauvegarder
keymap('n', '<C-q>', ':q<CR>', { desc = "Quitter Neovim" })
-- Mode insertion : Quitte NEOVIM sans quitter le mode Insertion
keymap('i', '<C-q>', '<C-o>:qCR>', { desc = "Quitter Neovim" })
-- Mode visuel : Quitte NEOVIM et reste en mode Visuel
keymap('v', '<C-q>', '<Esc>:qCR>', { desc = "Quitter Neovim" })
-- ===================================================================
-- ===================================================================
-- FORCE QUITTER NEOVIM (CTRL + SHIFT + Q)
-- ===================================================================
-- Mode normal : Quitte NEOVIM
-- On utilise :q! pour forcer la fermeture sans sauvegarder
keymap('n', '<C-S-q>', ':q!<CR>', { desc = "Force Quit Current (No Save)" })
-- Mode insertion : Quitte NEOVIM sans quitter le mode Insertion
keymap('i', '<C-S-q>', '<C-o>:q!<CR>', { desc = "Force Quit Current (No Save)" })
-- Mode visuel : Quitte NEOVIM et reste en mode Visuel
keymap('v', '<C-S-q>', '<Esc>:q!<CR>', { desc = "Force Quit Current (No Save)" })
-- ===================================================================
-- ===================================================================
-- UNDO / REDO (STYLE VS CODE)
-- ===================================================================
-- Bloquer la suspension du terminal par CTRL+Z
keymap({ 'n', 'v', 'i' }, '<C-z>', '<nop>', opts)
-- Mode NORMAL
keymap("n", "<C-z>", "u", { desc = "Undo" })
keymap("n", "<C-y>", "<C-r>", { desc = "Redo" })
keymap("n", "<C-r>", "<C-r>", { desc = "Redo (Natif)" })
keymap("n", "U", "<C-r>", { desc = "Redo (Maj)" })

-- Mode INSERTION
keymap("i", "<C-z>", "<C-o>u", { desc = "Undo" })
keymap("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })

-- Mode VISUEL
keymap("v", "<C-z>", "<Esc>ugv", { desc = "Undo" })
keymap("v", "<C-y>", "<Esc><C-r>gv", { desc = "Redo" })

-- ===================================================================
-- SÉLECTION DE LIGNE (CTRL + L)
-- ===================================================================
-- Mode Normal : Sélectionne la ligne actuelle
keymap('n', '<C-l>', 'V', { desc = "Sélectionner la ligne" })
-- Mode Insertion : Sort du mode et sélectionne la ligne
keymap('i', '<C-l>', '<Esc>V', { desc = "Sélectionner la ligne" })
-- Mode Visuel : Étend la sélection à la ligne suivante (très utile)
keymap('v', '<C-l>', 'j', { desc = "Sélectionner ligne suivante" })

-- Lecture rapide de fichier sans quitter le buffer (Preview)
-- Utilise 'fp' (File Preview) pour ouvrir Telescope buffer en mode preview uniquement
keymap('n', 'fp', function()
    require('telescope.builtin').find_files({
        previewer = true,
        layout_strategy = 'vertical',
        layout_config = {
            width = 0.9,
            height = 0.9,
            preview_height = 0.7, -- Grande zone de lecture
        },
        attach_mappings = function(_, map)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            -- On map <Esc> pour quitter directement au lieu de passer en mode normal
            map('i', '<Esc>', actions.close)

            -- Entrée ouvre le fichier dans un split vertical
            map('i', '<C-x>', function(prompt_bufnr)
                actions.file_vsplit(prompt_bufnr)
            end)

            -- Si tu veux aussi un raccourci pour split horizontal, par exemple <C-x>
            map('i', '<CR>', actions.file_split)

            return true
        end,
    })
end, { desc = "File Preview (Read Only)" })

-- Toggle Git Blame sur la ligne courante
keymap('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', { desc = "Toggle Git Blame Line" })

-- Toggle Diagnostics (erreurs/warnings LSP)
local diagnostics_visible = true
keymap('n', '<leader>td', function()
    diagnostics_visible = not diagnostics_visible
    vim.diagnostic.enable(diagnostics_visible)
end, { desc = "Toggle Diagnostics" })

-- ===================================================================
-- TERMINAL TOGGLE (CTRL + K)
-- ===================================================================
-- Fonction pour basculer le terminal (Toggle)
-- local function toggle_terminal()
--   local term_buf = nil
--   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--     if vim.bo[buf].buftype == "terminal" then
--       term_buf = buf
--       break
--     end
--   end
--
--   local win = vim.fn.bufwinid(term_buf or -1)
--   if win ~= -1 then
--     -- Si le terminal est ouvert, on le cache
--     vim.api.nvim_win_hide(win)
--   else
--     -- Sinon on l'ouvre (en bas, taille 15)
--     if term_buf then
--       vim.cmd("botright sbuf " .. term_buf)
--     else
--       vim.cmd("botright split | term")
--     end
--     vim.cmd("resize 15")
--     vim.cmd("startinsert")
--   end
-- end

local function toggle_terminal()
    local term_buf = nil
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buftype == "terminal" then
            term_buf = buf
            break
        end
    end

    local win = vim.fn.bufwinid(term_buf or -1)
    if win ~= -1 then
        vim.api.nvim_win_hide(win)
    else
        vim.cmd("botright 15split | " .. (term_buf and ("buffer " .. term_buf) or "term"))
        vim.cmd("startinsert")
    end
end
-- vim.keymap.set({ 'n', 't' }, '<C-k>', toggle_terminal, { desc = "Toggle Terminal" })

-- Mappings avec CTRL + k
-- En mode Normal pour ouvrir
-- vim.keymap.set('n', '<C-k>', toggle_terminal, { desc = "Toggle Terminal" })
-- En mode Terminal pour cacher
-- vim.keymap.set('t', '<C-k>', toggle_terminal, { desc = "Hide Terminal" })

-- Quitter le mode insertion dans le terminal avec CTRL + x
-- (Très utile pour remonter dans ton historique gdb sur Rainfall)
vim.keymap.set('t', '<C-x>', [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

-- Raccourci pour ouvrir les fichiers de config
vim.keymap.set('n', 'cf', function()
    require('telescope.builtin').find_files({
        prompt_title = " Config Files",
        cwd = "~/.config/nvim", -- Telescope cherche uniquement ici
        hidden = true,          -- Pour voir les fichiers cachés comme .zshrc
    })
end, { desc = "Open Config Files" })

-- Fin du fichier keymaps.lua

-- ===================================================================
-- BUFFERLINE (TABS) NAVIGATION
-- ===================================================================
-- Cycle through buffers (tabs)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })
keymap("n", "<C-PageUp>", ":BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
keymap("n", "<C-PageDown>", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })

-- Move buffers
keymap("n", "<leader>b<Left>", ":BufferLineMovePrev<CR>", { desc = "Move Buffer Left" })
keymap("n", "<leader>b<Right>", ":BufferLineMoveNext<CR>", { desc = "Move Buffer Right" })

-- Close buffer (keeps window open)
keymap("n", "<leader>x", ":bdelete<CR>", { desc = "Close Buffer" })
keymap("n", "<leader>bp", ":BufferLinePick<CR>", { desc = "Pick Buffer" })

-- Raccourci pour SCP remote edit
-- Anciennement scp://, maintenant optimisé pour oil-ssh://
-- Note: Pour que oil-ssh fonctionne, il faut juste utiliser oil-ssh:// au lieu de scp://
keymap("n", "<leader>re", ":e oil-ssh://user@host//path/to/file", { desc = "Remote Edit (Oil-SSH)" })
