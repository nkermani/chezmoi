-- lua/core/options.lua
-- Options

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ===================================================================
-- PERSISTENT UNDO (Historique des modifications)
-- ===================================================================

if vim.fn.has("unix") == 1 then
    local undodir = os.getenv("HOME") .. "/.vim/undodir"
    -- Créer le dossier s'il n'existe pas
    if vim.fn.isdirectory(undodir) == 0 then
        vim.fn.mkdir(undodir, "p")
    end

    vim.opt.undodir = undodir
    vim.opt.undofile = true
end

vim.opt.endofline = true    -- S'assure qu'il y a un \n à la fin
vim.opt.fixendofline = true -- Rétablit le \n s'il est supprimé
vim.opt.autochdir = false   -- Neovim change de dossier de travail automatiquement vers le fichier ouvert

vim.opt.mouse = "a"         -- Active la souris partout
-- vim.opt.mousemodel = "extend" -- Permet des sélections souris fluides
vim.opt.selection = "inclusive"

-- Interface
vim.opt.number = true          -- Affiche les numéros de ligne
vim.opt.relativenumber = false -- Numéros relatifs (très utile pour sauter des lignes)
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.termguicolors = true
-- Remplace le tilde (~) par un espace vide et améliore les séparateurs
vim.opt.fillchars = { eob = " ", vert = "│", horiz = "─", diff = "╱", fold = " ", msgsep = "‾", foldopen = "", foldsep = "│", foldclose = "" }
vim.opt.laststatus = 3 -- Global statusline
-- vim.opt.winbar = "%f %m" -- Show filename in each window bar for clarity

vim.opt.wrap = true -- Désactive le retour à la ligne pour permettre le scroll horizontal

-- Indentation (Standard Rust/C)
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true -- Utilise des espaces au lieu de tabulations
vim.opt.smartindent = true

-- Comportement
vim.opt.ignorecase = true -- Ignore la casse lors de la recherche...
vim.opt.smartcase = true  -- ...sauf s'il y a une majuscule
vim.opt.updatetime = 250  -- Plus rapide pour les diagnostics LSP
vim.opt.scrolloff = 8     -- Garde 8 lignes visibles en haut/bas
vim.opt.backspace = "indent,eol,start"
-- Synchronise le presse-papier de Neovim avec le presse-papier du système
-- Cela permet de copier dans Neovim et coller dans Chrome (et inversement) sans config spéciale
vim.opt.clipboard = "unnamedplus"

-- Amélioration de l'expérience de "Yank"
-- Met en surbrillance le texte copié pendant quelques millisecondes (très visuel et pratique)
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

-- Fonction pour nettoyer les espaces et les lignes vides
local function clean_on_save()
    -- Ne pas exécuter si on est dans un fichier python (laisser black gérer)
    if vim.bo.filetype == "python" then
        return
    end

    -- Mémoriser la position du curseur
    local save_cursor = vim.fn.getpos(".")

    -- 1. Supprimer les espaces en fin de ligne
    vim.cmd([[%s/\s\+$//e]])

    -- 2. Compresser les lignes vides multiples (3 ou plus deviennent 2)
    -- Cela laisse une seule ligne vide entre deux blocs de texte
    vim.cmd([[%s/\n\{3,}/\r\r/e]])

    -- 3. Ajouter UNE ligne vide à la fin si elle n'existe pas
    local last_line = vim.api.nvim_buf_line_count(0)
    local last_content = vim.api.nvim_buf_get_lines(0, last_line - 1, last_line, false)[1]
    if last_content ~= "" then
        vim.api.nvim_buf_set_lines(0, last_line, last_line, false, { "" })
    end

    -- Replacer le curseur
    vim.fn.setpos(".", save_cursor)
end

-- L'autocommande reste la même
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = clean_on_save,
})

-- Sauvegarder automatiquement quand Neovim perd le focus
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
    pattern = "*",
    command = "silent! wa", -- 'wa' sauvegarde tous les buffers modifiés sans erreur
})

vim.opt.signcolumn = "yes:2"
