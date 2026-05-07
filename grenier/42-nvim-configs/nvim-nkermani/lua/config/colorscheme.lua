-- lua/config/colorscheme.lua
-- Colorscheme configuration

-- Liste des thèmes disponibles (alias -> nom réel du colorscheme)
local themes = {
    vscode = "vscode",
    everforest = "everforest",
    github = "github_dark", -- ou github_light, github_dark_dimmed
    gruvbox = "gruvbox-material",
    monokai_pro = "monokai-pro",
    vesper = "vesper",
    kanagawa = "kanagawa",
    one_monokai = "one_monokai",
    sonokai = "sonokai",
    catppuccin = "catppuccin",
    tokyonight = "tokyonight", -- Variantes: tokyonight-storm, tokyonight-night, tokyonight-moon, tokyonight-day
    cyberdream = "cyberdream",
    cyberpunk_nk = "cyberpunk_nk",
}

-- CONFIGURATION PRINCIPALE
local main_theme = themes.cyberpunk_nk

-- =============================================================================
-- Chargement sécurisé des plugins de thèmes
-- =============================================================================

local function safe_require(name)
    local ok, plugin = pcall(require, name)
    return ok and plugin or nil
end

local kanagawa = safe_require("kanagawa")
local monokai = safe_require("one_monokai")
local catppuccin = safe_require("catppuccin")
local tokyonight = safe_require("tokyonight")
local monokai_pro = safe_require("monokai-pro")
local github_theme = safe_require("github-theme")
local cyberdream = safe_require("cyberdream")
local cyberpunk_nk = safe_require("config.cyberpunk_theme")

-- =============================================================================
-- Configurations spécifiques des thèmes
-- =============================================================================

if cyberpunk_nk then
    -- La configuration se fait via le fichier colors/cyberpunk_nk.lua
    -- qui appelle config.cyberpunk_theme.setup()
end

if cyberdream then
    cyberdream.setup({
        transparent = false,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
        terminal_colors = true,
    })
end

if tokyonight then
    tokyonight.setup({
        style = "storm",     -- storm, moon, a night, day
        transparent = false, -- Activer la transparence si souhaité
        terminal_colors = true,
        styles = {
            comments = { italic = true },
            keywords = { italic = true },
        },
    })
end

if kanagawa then
    kanagawa.setup({
        transparent = false,
        theme = "wave", -- wave, dragon, lotus
        overrides = function(colors)
            return {}
        end,
    })
end

if monokai then
    monokai.setup({
        transparent = false,
    })
end

if catppuccin then
    catppuccin.setup({
        flavour = "frappe", -- lattee, frappe, macchiato, mocha
        transparent_background = false,
    })
end

if monokai_pro then
    monokai_pro.setup({
        transparent_background = false,
        terminal_colors = true,
        filter = "pro", -- classic, machine, octagon, pro, ristretto, spectrum
    })
end

if github_theme then
    github_theme.setup({
        options = {
            transparent = false,
        }
    })
end

-- Variables Globales pour les thèmes Vim-script (Sonokai, Everforest, Gruvbox)
vim.g.sonokai_style = 'shusia'
vim.g.sonokai_transparent_background = 0
vim.g.sonokai_better_performance = 1

vim.g.everforest_background = 'light'
vim.g.everforest_transparent_background = 0

vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_transparent_background = 0

-- =============================================================================
-- Application du Thème
-- =============================================================================

local function apply_theme(theme_name)
    local ok, _ = pcall(vim.cmd, "colorscheme " .. theme_name)
    if not ok then
        vim.notify("Thème '" .. theme_name .. "' introuvable. Chargement de 'industry'.", vim.log.levels.WARN)
        vim.cmd("colorscheme industry")
    end
end

-- Appliquer le thème choisi
apply_theme(main_theme)

-- Overrides globaux pour l'esthétique (Bordures et Séparateurs)
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#424242" })
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#424242" })

-- Optionnel : commande pour changer de thème à la volée
vim.api.nvim_create_user_command("ThemeSwap", function(opts)
    local new_theme = opts.args
    if new_theme and new_theme ~= "" then
        apply_theme(new_theme)
    else
        print("Usage: :ThemeSwap <theme_name>")
    end
end, {
    nargs = 1,
    complete = function()
        return vim.tbl_values(themes)
    end,
})
