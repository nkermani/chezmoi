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

    indent = {
        enabled = true,
        char = "│",
        scope = {
            enabled = true,
            char = "│",
        },
    },

    zen = {
        enabled = true,
        minimal = false,
        toggles = {
            dim = false,
            git = false,
            diagnostics = true,
        },
        show = {
            statusline = true,
            tabline = true,
        },
        win = {
            width = 0.85,
            height = 0.85,
            border = "rounded",
            backdrop = { transparent = false, opacity = 100 },
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
    },
})

-- === RACCOURCIS UTILES ===
local keymap = vim.keymap.set

keymap("n", "<leader>z", function() snacks.zen() end, { desc = "Toggle Zen Mode" })
keymap("n", "<leader>Z", function() snacks.zen.zoom() end, { desc = "Toggle Zoom Mode" })

-- Supprimer le buffer actuel proprement sans fermer ta fenêtre/split
keymap("n", "<leader>bd", function() snacks.bufdelete() end, { desc = "Delete Buffer" })

-- Notifications : Historique
keymap("n", "<leader>nh", function() snacks.notifier.show_history() end, { desc = "Notification History" })

-- Renommer un fichier physiquement et mettre à jour les imports
keymap("n", "<leader>rn", function() snacks.rename.rename_file() end, { desc = "Rename File" })

