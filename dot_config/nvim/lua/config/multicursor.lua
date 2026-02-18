vim.g.VM_default_mappings = 0
vim.g.VM_mouse_mappings = 1
vim.g.VM_theme = 'ocean'

vim.g.VM_maps = {
    ['Find Under']         = '<C-d>',
    ['Find Subword Under'] = '<C-d>',
    ['Select All']         = '<C-S-a>',
    ['Add Cursor Down']    = '<C-M-S-Down>',
    ['Add Cursor Up']      = '<C-M-S-Up>',
    ['Skip Region']        = '<C-x>',
    ['Remove Region']      = 'q',
    ['Undo']               = 'u',
    ['Redo']               = '<C-r>',
    ['Switch Mode']        = 'v',
}

local keymap = vim.keymap.set

keymap('n', '<C-d>', '<Plug>(VM-Find-Under)', { silent = true, desc = "Multi-cursor: Find Under" })
keymap('n', '<leader>mc', '<Plug>(VM-Add-Cursor-At-Pos)', { silent = true, desc = "Multi-cursor: Add Cursor at Pos" })
keymap('n', '<M-LeftMouse>', '<Plug>(VM-Mouse-Cursor)', { silent = true })
keymap('v', '<M-LeftMouse>', '<Plug>(VM-Mouse-Cursor)', { silent = true })
