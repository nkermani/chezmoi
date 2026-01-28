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

-- Fonction pour changer de répertoire de travail (CD)
local change_directory = function()
    builtin.find_files({
        prompt_title = "📂 Change Directory",
        find_command = { "fd", "--type", "d", "--max-depth", "5", "--hidden", "--exclude", ".git", "--exclude", "node_modules" },
        previewer = false,
        layout_config = {
            width = 0.5,
            height = 0.4,
        },
        attach_mappings = function(prompt_bufnr, map)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")

            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    local dir = selection[1]
                    vim.cmd("cd " .. dir)
                    vim.notify("Changed directory to: " .. dir, vim.log.levels.INFO)
                end
            end)
            return true
        end,
    })
end

-- Fonction pour se connecter rapidement à un remote via Oil-SSH
local remote_ssh_connect = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values

    -- Liste de tes serveurs habituels (à personnaliser)
    local hosts = {
        { name = "Rainfall (42)", url = "oil-ssh://nkermani@rainfall//home/nkermani/" },
        { name = "Goinfre (42)", url = "oil-ssh://nkermani@rainfall//goinfre/nkermani/" },
        -- Ajoute d'autres serveurs ici
        -- { name = "Mon Serveur", url = "oil-ssh://user@ip//path/" },
    }

    pickers.new({}, {
        prompt_title = "🌐 Remote Connection (Oil-SSH)",
        finder = finders.new_table({
            results = hosts,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.name,
                    ordinal = entry.name,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd("edit " .. selection.value.url)
            end)
            return true
        end,
    }):find()
end

vim.keymap.set("n", "<leader>rr", remote_ssh_connect, { desc = "Remote Hosts (Telescope)" })

