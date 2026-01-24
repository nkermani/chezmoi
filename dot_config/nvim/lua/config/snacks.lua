-- lua/config/snacks.lua
-- folke/snacks.nvim -> A collection of small QoL plugins for Neovim
local ok, snacks = pcall(require, "snacks")
if not ok then return end

snacks.setup({
    -- Notificateur stylisé (remplace les messages classiques moches)
    notifier = {
        enabled = true,
        timeout = 3000, -- 3 secondes
    },

    -- Gestion des gros fichiers (désactive les plugins lourds sur les fichiers énormes)
    bigfile = { enabled = true },

    -- Animation fluide du scroll (très agréable visuellement)
    scroll = { enabled = true },

    -- Dashboard (Optionnel si tu préfères Snacks à Alpha, mais on le laisse désactivé pour l'instant)
    dashboard = { enabled = false },

    -- Indentations (Peut remplacer indent-blankline si tu veux)
    indent = {
        enabled = true,
        char = "╎", -- Un caractère fin pour le look "clean"
        scope_char = "┃", -- Un caractère plus épais pour la portée actuelle
        only_scope = false, -- Affiche les lignes partout (mettre à true pour encore plus de minimalisme)
        animate = {
            enabled = true, -- Ajoute une animation fluide sur le changement de scope
            style = "out", -- Effet de "fading"
        },
        blank = {
            char = " ", -- Pas de caractères sur les lignes vides (très clean)
        },
    },

    -- Pour faire des captures d'écran de ton code (Super pour tes projets 42 !)
    input = { enabled = true },
})

-- === RACCOURCIS UTILES ===
local keymap = vim.keymap.set

-- Supprimer le buffer actuel proprement sans fermer ta fenêtre/split
keymap("n", "<leader>bd", function() snacks.bufdelete() end, { desc = "Delete Buffer" })

-- Notifications : Historique
keymap("n", "<leader>nh", function() snacks.notifier.show_history() end, { desc = "Notification History" })

-- Renommer un fichier physiquement et mettre à jour les imports
keymap("n", "<leader>rn", function() snacks.rename.rename_file() end, { desc = "Rename File" })
