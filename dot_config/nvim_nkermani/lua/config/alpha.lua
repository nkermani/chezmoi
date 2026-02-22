-- lua/config/alpha.lua
local ok, alpha = pcall(require, "alpha")
if not ok then return end

local dashboard = require("alpha.themes.dashboard")

-- 1. Définition de ton Header ASCII
dashboard.section.header.val = {
    " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
}
dashboard.section.header.opts.hl = "AlphaHeader"

-- 2. Configuration des boutons (uniquement Find Files et Grep)
dashboard.section.buttons.val = {
    -- NAVIGATION
    dashboard.button("e", "󰙅  File Explorer (Oil)", ":Oil<CR>"),
    dashboard.button("f", "󰈞  Find Files (Working Dir)", ":Telescope find_files<CR>"),
    dashboard.button("r", "󰋜  Search Home (~/)", ":Telescope find_files cwd=~<CR>"),
    -- Dans ton fichier alpha.lua, cherche la partie dashboard.button("p", ...)
    dashboard.button("p", "󱔗  Find Project", ":Telescope find_files cwd=~ find_command=fd,--type,d,--max-depth,7 previewer=false<CR>"),

    -- CONFIGURATION
    dashboard.button("c", "󰒓  Config Files", ":Telescope find_files cwd=~/.config/nvim<CR>"),

    -- RECHERCHE & ÉDITION
    dashboard.button("w", "󰱽  Search Text (Grep)", ":Telescope live_grep<CR>"),
    dashboard.button("n", "󰝒  New File", ":ene | startinsert<CR>"),

    -- HISTORIQUE & SYSTÈME
    dashboard.button("s", "󰄉  Recent Files (History)", ":Telescope oldfiles<CR>"),
    dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
}

for _, button in ipairs(dashboard.section.buttons.val) do
    button.opts.hl = "AlphaButton"
    button.opts.hl_shortcut = "AlphaButtonShortcut"
end

-- 3. Optionnel : Enlever la ligne de "footer" (nombre de plugins) pour rester minimaliste
dashboard.section.footer.val = ""

-- Activer le clic sur Alpha
vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
        -- On utilise une fonction Lua pour garantir que le curseur est bien placé avant de valider
        vim.keymap.set("n", "<LeftMouse>", function()
            -- 1. Récupère les coordonnées de la souris et place le curseur
            local mouse_pos = vim.fn.getmousepos()
            vim.api.nvim_win_set_cursor(0, {mouse_pos.line, mouse_pos.column - 1})

            -- 2. Simule l'appui sur Entrée
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "m", true)
        end, { buffer = true, silent = true })
    end,
})

alpha.setup(dashboard.opts)

