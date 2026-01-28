-- lua/config/telescope.lua
-- nvim-telescope/telescope.nvim -> telescope.nvim is a highly extendable fuzzy finder over lists.
local ok, telescope = pcall(require, "telescope")
if not ok then return end

local builtin = require("telescope.builtin")

-- 2. SETUP TELESCOPE
telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
            },
        },
        file_ignore_patterns = {
            "node_modules", ".git/", ".cache", "Downloads/", "Documents/42/utils/",
        },

        -- CONFIGURATION DYNAMIQUE DE L'ÉCRAN
        layout_strategy = "flex",
        layout_config = {
            flex = {
                flip_columns = 120, -- Bascule en mode vertical si moins de 120 colonnes
            },
            horizontal = {
                preview_width = 0.6,
                preview_cutoff = 60,
            },
            vertical = {
                preview_height = 0.5,
                preview_cutoff = 0, -- Force la preview même si la fenêtre est petite
            },
        },
        -- Configuration de la fenêtre de preview pour enlever les marges
        path_display = { "truncate" },
        winblend = 0,
        border = true,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
})

-- 3. RACCOURCIS (KEYMAPS)
local keymap = vim.keymap.set

-- Navigation de fichiers
keymap("n", "ff", builtin.find_files, { desc = "Telescope find files" })
keymap("n", "fg", builtin.live_grep, { desc = "Telescope live grep" })
keymap("n", "fb", builtin.buffers, { desc = "Telescope buffers" })

-- Recherche avancée
keymap("n", "fs", builtin.grep_string, { desc = "Find current word" })
keymap("n", "fr", builtin.oldfiles, { desc = "Recent files" })
keymap("n", "fk", builtin.keymaps, { desc = "Show keymaps" })
keymap("n", "ft", builtin.help_tags, { desc = "Telescope help tags" })

-- Recherche HOME
keymap("n", "fh", function()
    builtin.find_files({
        cwd = "~",
        prompt_title = "Search in Home (~)",
        hidden = true
    })
end, { desc = "Telescope find files in HOME" })

-- Fonction utilisée par le bouton 'p' d'Alpha
local find_projects = function()
    builtin.find_files({
        prompt_title = "🚀 Projects",
        -- On cherche uniquement les dossiers (ou ce que tu considères comme un projet)
        find_command = { "fd", "--type", "d", "--max-depth", "7", "--hidden", "--exclude", ".git" },
        previewer = false, -- DESACTIVE LA PREVIEW ICI
        layout_config = {
            width = 0.5,
            height = 0.4,
        },
    })
end

-- Raccourci pour pouvoir l'appeler depuis Alpha ou ailleurs
vim.keymap.set("n", "<leader>fp", find_projects, { desc = "Find Projects (No Preview)" })
