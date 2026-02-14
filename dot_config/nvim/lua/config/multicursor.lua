vim.g.VM_default_mappings = 0
vim.g.VM_mouse_mappings = 1
vim.g.VM_theme = 'ocean'

vim.g.VM_maps = {
  ['Find Under']         = '<C-d>',
  ['Find Subword Under'] = '<C-d>',
  ['Select All']         = '<C-S-a>',
  ['Add Cursor Down']    = '<C-Down>',
  ['Add Cursor Up']      = '<C-Up>',
  ['Remove Region']      = '<C-S-d>',
}


-- Mappings pour entrer dans le mode
vim.keymap.set('n', '<C-d>', '<Plug>(VM-Find-Under)', { silent = true })
vim.keymap.set('n', '<M-LeftMouse>', '<Plug>(VM-Mouse-Cursor)', { silent = true })
