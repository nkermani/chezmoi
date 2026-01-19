local keymap = vim.keymap.set
-- lua/core/keymaps.lua

-- Crée des points d'undo sur les caractères de ponctuation
local chars = {',', '.', '!', '?', ';', ' ', '(', ')', '[', ']', '{', '}'}
for _, char in ipairs(chars) do
  keymap('i', char, char .. '<c-g>u', { noremap = true, silent = true })
end

-- Désactive la suspension de Neovim avec CTRL+Z
vim.keymap.set({'n', 'v', 'i'}, '<C-z>', '<nop>')
vim.keymap.set({'n', 'v', 'i'}, '<C-S-z>', '<nop>')

-- Changer de fenêtre (split) avec CTRL + Flèches
keymap("n", "<C-Left>", "<C-w>h", { desc = "Fenêtre de gauche" })
-- keymap("n", "<C-Down>", "<C-w>j", { desc = "Fenêtre du bas" })
-- keymap("n", "<C-Up>", "<C-w>k", { desc = "Fenêtre du haut" })
keymap("n", "<C-Right>", "<C-w>l", { desc = "Fenêtre de droite" })
-- Navigation rapide entre les splits avec Ctrl + hjkl
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

keymap("n", "<S-Right>", "l", { desc = "Move right" })
keymap("n", "<S-Left>", "h", { desc = "Move left" })

keymap("v", "<S-Right>", "l", { desc = "Extend selection right" })
keymap("v", "<S-Left>", "h", { desc = "Extend selection left" })

-- CTRL + SHIFT + UP pour aller tout en haut (gg)
keymap("n", "<C-S-Up>", "gg", { desc = "Go to top of file" })
keymap("i", "<C-S-Up>", "<C-o>gg", { desc = "Go to top of file from Insert" })

-- CTRL + SHIFT + DOWN pour aller tout en bas (G)
keymap("n", "<C-S-Down>", "G", { desc = "Go to bottom of file" })
keymap("i", "<C-S-Down>", "<C-o>G", { desc = "Go to bottom of file from Insert" })

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
    print("Vérification des plugins en cours...")
end, { desc = "Plugins Install/Check" })

-- Raccourci pour synchroniser vers START après l'install
vim.keymap.set('n', '<leader>ps', ':!./sync_plugins.sh<CR>', { desc = "Sync Plugins to Start" })

-- Garde le contenu du presse-papier après avoir collé sur une sélection
-- (Évite que le texte remplacé ne vienne écraser ton copier)
keymap("x", "p", [["_dP]])

-- Copier/Couper vers le registre système explicitement (au cas où)
keymap({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
-- Appuyer sur Échap pour enlever la surbrillance de la recherche (hlsearch)
keymap("n", "<Esc>", "<cmd>noh<cr><Esc>", { desc = "Clear search highlights" })

-- Toggle les numéros de ligne (Absolute et Relative)
vim.keymap.set('n', '<leader>nl', function()
    vim.opt.number = not vim.opt.number:get()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle Line Numbers" })

-- ===================================================================
-- NAVIGATION STYLE VSCODE (Normal, Insert, Visual)
-- ===================================================================
-- 1. DÉBUT / FIN DE LIGNE (Home/End & ALT + Flèches)
local directions = {
    { mode = {'n', 'i', 'v'}, keys = {'<Home>', '<M-Left>'},  target = '^', desc = "Début de ligne" },
    { mode = {'n', 'i', 'v'}, keys = {'<End>',  '<M-Right>'}, target = '$', desc = "Fin de ligne" }
}

for _, map in ipairs(directions) do
    for _, key in ipairs(map.keys) do
        keymap(map.mode[1], key, map.mode[1] == 'i' and ('<C-o>' .. map.target) or map.target, opts)
        keymap(map.mode[2], key, map.target, opts) -- Pour Visual
        if map.mode[3] then keymap(map.mode[3], key, map.target, opts) end
    end
end

-- ===================================================================
-- NAVIGATION DÉBUT/FIN DE LIGNE (HOME/END & ALT + FLECHES)
-- ===================================================================

-- Mode NORMAL
keymap('n', '<M-Left>',  '^', opts)
keymap('n', '<M-Right>', '$', opts)
keymap('n', '<Home>',    '^', opts)
keymap('n', '<End>',     '$', opts)

-- Mode INSERTION
-- On utilise <C-o> pour exécuter une commande normale sans quitter l'insert
keymap('i', '<M-Left>',  '<C-o>^', opts)
keymap('i', '<M-Right>', '<C-o>$', opts)
keymap('i', '<Home>',    '<C-o>^', opts)
keymap('i', '<End>',     '<C-o>$', opts)

-- Mode VISUEL
-- En visuel, on veut déplacer le curseur pour étendre la sélection
keymap('v', '<M-Left>',  '^', opts)
keymap('v', '<M-Right>', '$', opts)
keymap('v', '<Home>',    '^', opts)
keymap('v', '<End>',     '$', opts)

-- 2. MOT PAR MOT (CTRL + Flèches)
keymap({'n', 'v'}, '<C-Left>',  'b', opts)
keymap({'n', 'v'}, '<C-Right>', 'w', opts)
keymap('i',        '<C-Left>',  '<C-o>b', opts)
keymap('i',        '<C-Right>', '<C-o>w', opts)

-- 3. SÉLECTION MOT PAR MOT (CTRL + SHIFT + Flèches)
keymap('n', '<C-S-Left>',  'vb', opts)
keymap('n', '<C-S-Right>', 'vw', opts)
keymap('i', '<C-S-Left>',  '<Esc>vb', opts)
keymap('i', '<C-S-Right>', '<Esc>vw', opts)
keymap('v', '<C-S-Left>',  'b', opts)
keymap('v', '<C-S-Right>', 'w', opts)

-- 4. SUPPRESSION MOT ENTIER (CTRL + Backspace / ALT + Backspace)
-- Note: Dans certains terminaux CTRL+BS envoie <C-H> ou <C-w>
keymap('i', '<C-BS>',    '<C-w>', opts)
keymap('i', '<M-BS>',    '<C-w>', opts)
keymap('i', '<C-H>',     '<C-w>', opts) -- Pour certains terminaux Linux

-- Mode Normal : Supprimer le mot avant le curseur
keymap('n', '<C-BS>',    'db', opts)
keymap('n', '<M-BS>',    'db', opts)
keymap('n', '<C-H>',     'db', opts) -- Pour certains terminaux Linux

-- 5. FORMATAGE & ÉCRAN
keymap('n', '<leader>nl', ':set number!<CR>', { desc = "Toggle Line Numbers" })

-- CTRL + Delete pour supprimer le mot suivant (Mode Normal)
keymap("n", "<C-Delete>", "dw", { desc = "Delete word forward" })
-- CTRL + Delete pour supprimer le mot suivant (Mode Insertion)
-- On passe en mode normal temporairement pour faire 'dw' puis on revient en insertion
keymap("i", "<C-Delete>", "<C-o>dw", { desc = "Delete word forward in insert mode" })
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
keymap('i', '<C-v>', '<C-o>"+p', { desc = "Coller depuis le presse-papier système" })
-- Mode Visuel : Remplacer la sélection par le contenu du presse-papier système
keymap('v', '<C-v>', '"+p', { desc = "Coller depuis le presse-papier système" })

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
keymap('n', '<M-Up>',   ':m .-2<CR>==', opts)
keymap('i', '<M-Down>', '<Esc>:m .+1<CR>==gi', opts)
keymap('i', '<M-Up>',   '<Esc>:m .-2<CR>==gi', opts)
keymap('v', '<M-Down>', ":m '>+1<CR>gv=gv", opts)
keymap('v', '<M-Up>',   ":m '<-2<CR>gv=gv", opts)

-- DUPLIQUER des lignes (Shift + Alt + Flèches)
keymap('n', '<S-M-Down>', 'yyp', opts)
keymap('n', '<S-M-Up>',   'yyP', opts)
keymap('i', '<S-M-Down>', '<Esc>yypgi', opts)
keymap('i', '<S-M-Up>',   '<Esc>yyPgi', opts)
keymap('v', '<S-M-Down>', "yPgv", opts)
keymap('v', '<S-M-Up>',   "yPgv", opts)

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
keymap({'n', 'i', 'v'}, '<M-ScrollWheelDown>', '15<C-e>', opts)
keymap({'n', 'i', 'v'}, '<M-ScrollWheelUp>', '15<C-y>', opts)

-- ===================================================================
-- SCROLL HORIZONTAL (SHIFT + MOLETTE)
-- ===================================================================

-- Scroll vers le bas plus vite (5 lignes par cran)
keymap({'n', 'i', 'v'}, '<S-ScrollWheelDown>', '5zh', opts)
keymap({'n', 'i', 'v'}, '<S-2-ScrollWheelDown>', '5zh', opts) -- Gère le double-clic de molette

-- Scroll vers le haut plus vite (5 lignes par cran)
keymap({'n', 'i', 'v'}, '<S-ScrollWheelUp>', '5zl', opts)
keymap({'n', 'i', 'v'}, '<S-2-ScrollWheelUp>', '5zl', opts)

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
keymap({"n", "v"}, "x", '"_x', opts)

-- Supprimer (d, dd, D)
keymap({"n", "v"}, "d", '"_d', opts)
keymap({"n", "v"}, "D", '"_D', opts)

-- Supprimer et insérer (c, C) - Optionnel mais souvent souhaité
keymap({"n", "v"}, "c", '"_c', opts)
keymap({"n", "v"}, "C", '"_C', opts)

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
keymap('n', '<C-S-q>', ':!q<CR>', { desc = "Quitter Neovim" })
-- Mode insertion : Quitte NEOVIM sans quitter le mode Insertion
keymap('i', '<C-S-q>', '<C-o>:!qCR>', { desc = "Quitter Neovim" })
-- Mode visuel : Quitte NEOVIM et reste en mode Visuel
keymap('v', '<C-S-q>', '<Esc>:!qCR>', { desc = "Quitter Neovim" })
-- ===================================================================
-- ===================================================================
-- UNDO / REDO (STYLE VS CODE)
-- ===================================================================
-- Bloquer la suspension du terminal par CTRL+Z
keymap({'n', 'v', 'i'}, '<C-z>', '<nop>', opts)
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

-- ===================================================================
-- TERMINAL TOGGLE (CTRL + K)
-- ===================================================================
-- Fonction pour basculer le terminal (Toggle)
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
    -- Si le terminal est ouvert, on le cache
    vim.api.nvim_win_hide(win)
  else
    -- Sinon on l'ouvre (en bas, taille 15)
    if term_buf then
      vim.cmd("botright sbuf " .. term_buf)
    else
      vim.cmd("botright split | term")
    end
    vim.cmd("resize 15")
    vim.cmd("startinsert")
  end
end

-- Mappings avec CTRL + k
-- En mode Normal pour ouvrir
vim.keymap.set('n', '<C-k>', toggle_terminal, { desc = "Toggle Terminal" })
-- En mode Terminal pour cacher
vim.keymap.set('t', '<C-k>', toggle_terminal, { desc = "Hide Terminal" })

-- Quitter le mode insertion dans le terminal avec CTRL + x
-- (Très utile pour remonter dans ton historique gdb sur Rainfall)
vim.keymap.set('t', '<C-x>', [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

-- Raccourci pour ouvrir les fichiers de config
vim.keymap.set('n', 'cf', function()
    require('telescope.builtin').find_files({
        prompt_title = " Config Files",
        cwd = "~/.config/nvim", -- Telescope cherche uniquement ici
        hidden = true,     -- Pour voir les fichiers cachés comme .zshrc
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
