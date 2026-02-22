-- lua/config/vim_visual_multi.lua
-- Configuration pour vim-visual-multi

-- Désactiver les mappings par défaut pour éviter les conflits
vim.g.VM_default_mappings = 0
vim.g.VM_mouse_mappings = 1
vim.g.VM_theme = 'ocean'

-- Définir les mappings personnalisés
vim.g.VM_maps = {
    ['Find Under']         = '<C-d>',           -- Sélectionner le mot sous le curseur
    ['Find Subword Under'] = '<C-d>',           -- Sélectionner le sous-mot
    ['Select All']         = '<C-S-d>',         -- Tout sélectionner (équivalent CTRL+D VSCode répété)
    ['Add Cursor Down']    = '<C-S-Down>',      -- Ajouter un curseur en bas (Ctrl+Shift+Down)
    ['Add Cursor Up']      = '<C-S-Up>',        -- Ajouter un curseur en haut (Ctrl+Shift+Up)
    ['Skip Region']        = '<C-x>',           -- Sauter la sélection actuelle (skip)
    ['Remove Region']      = 'q',               -- Enlever la sélection (custom)
}

-- Mappings directs pour initier le plugin
-- Note: <Plug>(VM-Find-Under) est la commande interne de vim-visual-multi
vim.keymap.set('n', '<C-d>', '<Plug>(VM-Find-Under)', { silent = true })
vim.keymap.set('n', '<C-LeftMouse>', '<Plug>(VM-Mouse-Cursor)', { silent = true })

-- S'assurer que CTRL+D ne scrolle pas en mode normal (déjà fait dans keymaps.lua mais rappel ici)
-- vim.keymap.set('n', '<C-d>', '<nop>', { noremap = true })
