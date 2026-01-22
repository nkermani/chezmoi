-- lua/config/colorscheme.lua
local ok_monokai, monokai = pcall(require, "one_monokai")
local ok_kanagawa, kanagawa = pcall(require, "kanagawa")

-- 1. Configurer Kanagawa (même si on ne l'utilise pas, pour éviter l'erreur Lualine)
if ok_kanagawa then
    kanagawa.setup({ transparent = true })
end

-- 2. Configurer One Monokai
if ok_monokai then
    monokai.setup({
        transparent = true,
        italics = true,
    })
    -- On applique One Monokai
    vim.cmd("colorscheme one_monokai")
else
    -- Fallback si One Monokai n'est pas trouvé
    vim.cmd("colorscheme habamax")
end

