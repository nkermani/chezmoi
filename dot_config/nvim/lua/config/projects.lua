local ok, project = pcall(require, "project_nvim")
if not ok then return end

project.setup({
  -- 1. Ajout de Cargo.toml pour tes projets Rust
  -- Ajout de "init.lua" ou ".nvim" pour détecter tes dossiers de config
  patterns = { ".git", "Makefile", "package.json", "Cargo.toml" },

  -- 2. Méthodes de détection
  -- On garde LSP en premier, c'est le plus précis
  detection_methods = { "lsp", "pattern" },

  -- 3. Gestion du dossier de travail (CWD)
  -- "false" permet de détecter le projet sans forcer le terminal à changer de dossier
  -- Change à "true" si tu veux que ton :pwd suive toujours ton fichier ouvert.
  update_cwd = true,

  -- 4. Mode Manuel
  -- Si tu l'actives (true), il n'enregistrera QUE les projets où tu fais :ProjectRoot
  manual_mode = false,

  -- 5. IMPORTANT : Empêcher la détection dans les dossiers système ou /tmp
  -- À 42, on veut éviter que /tmp ou le dossier des plugins devienne un "projet"
  exclude_dirs = { "~/.local/*", "~/.cache/*", "/tmp/*" },
})

-- Charger l'extension dans Telescope
require('telescope').load_extension('projects')

-- Raccourci
vim.keymap.set('n', '<leader>pp', ":Telescope projects<CR>", { desc = "List Projects" })

