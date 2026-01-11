local ok, neotree = pcall(require, "neo-tree")
if not ok then return end

neotree.setup({
    close_if_last_window = true,
    window = {
        width = 30,
        mappings = {
            ["<space>"] = "none", -- Désactive le focus espace pour tes keymaps
        }
    },
    filesystem = {
        filtered_items = {
            visible = true, -- Affiche les fichiers cachés par défaut
            hide_dotfiles = false,
            hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
    }
})

-- Raccourci pour ouvrir/fermer l'explorateur
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = "Toggle Neo-tree" })
