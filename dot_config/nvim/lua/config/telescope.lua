-- lua/config/telescope.lua
local ok, telescope = pcall(require, "telescope")
if not ok then return end

local previewers = require('telescope.previewers')
local builtin = require("telescope.builtin")

-- 1. FONCTION DE PREVIEW PERSONNALISÉE (BAT)
local bat_previewer = function(opts)
  return previewers.new_termopen_previewer({
    get_command = function(entry)
      local path = entry.path or entry.filename
      if path == nil or path == "" then return {"echo", "No preview available"} end

      local cmd = "bat"
      if vim.fn.executable("batcat") == 1 then cmd = "batcat" end

      return { cmd, "--style=numbers", "--color=always", "--pager=never", path }
    end
  })
end

-- 2. SETUP TELESCOPE (Optimisé pour écran scindé)
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

    -- Utilisation de bat pour tout
    file_previewer = bat_previewer,
    grep_previewer = bat_previewer,
    qflist_previewer = bat_previewer,

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

