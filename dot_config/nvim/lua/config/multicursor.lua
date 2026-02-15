-- Configuration pour vim-visual-multi (Multicursor style VSCode)
vim.g.VM_default_mappings = 0
vim.g.VM_mouse_mappings = 1
vim.g.VM_theme = 'ocean'

vim.g.VM_maps = {
  ['Find Under']         = '<C-d>',     -- Sélectionne le mot sous le curseur
  ['Find Subword Under'] = '<C-d>',
  ['Select All']         = '<C-S-a>',   -- Sélectionne toutes les occurrences
  ['Add Cursor Down']    = '<C-Down>',
  ['Add Cursor Up']      = '<C-Up>',
  ['Remove Region']      = '<C-S-d>',   -- Désélectionne l'actuel et revient en arrière (VSCode style)
}

-- Mappings pour entrer dans le mode multicurseur
vim.keymap.set('n', '<C-d>', '<Plug>(VM-Find-Under)', { silent = true })
vim.keymap.set('n', '<M-LeftMouse>', '<Plug>(VM-Mouse-Cursor)', { silent = true })
