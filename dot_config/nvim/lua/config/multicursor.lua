-- lua/config/multicursor.lua
vim.g.VM_default_mappings = 0
vim.g.VM_mouse_mappings = 1
vim.g.VM_theme = 'ocean'

vim.g.VM_maps = {
  ['Find Under']         = '<C-d>',
  ['Find Subword Under'] = '<C-d>',
  ['Select All']         = '<C-S-d>',
  ['Add Cursor Down']    = '<C-Down>',
  ['Add Cursor Up']      = '<C-Up>',
}

vim.keymap.set('n', '<C-d>', '<Plug>(VM-Find-Under)', { silent = true })
-- <C-LeftMouse> = Ctrl + Clic Gauche
vim.keymap.set('n', '<C-LeftMouse>', '<Plug>(VM-Mouse-Cursor)', { silent = true })

pcall(vim.keymap.del, 'i', '<C-d>')

