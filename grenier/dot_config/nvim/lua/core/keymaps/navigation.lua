-- lua/core/keymaps/navigation.lua
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 1. DÉBUT/FIN DE LIGNE (HOME/END / ALT + Flèches)
keymap('n', '<M-Left>', '^', opts)
keymap('n', '<M-Right>', '$', opts)
keymap('n', '<Home>', '^', opts)
keymap('n', '<End>', '$', opts)
keymap('i', '<M-Left>', '<C-o>^', opts)
keymap('i', '<M-Right>', '<C-o>$', opts)
keymap('i', '<Home>', '<C-o>^', opts)
keymap('i', '<End>', '<C-o>$', opts)
keymap('v', '<M-Left>', '^', opts)
keymap('v', '<M-Right>', '$', opts)
keymap('v', '<Home>', '^', opts)
keymap('v', '<End>', '$', opts)

-- 2. MOT PAR MOT (CTRL + Flèches)
keymap({ 'n', 'v' }, '<C-Left>', 'b', opts)
keymap({ 'n', 'v' }, '<C-Right>', 'w', opts)
keymap('i', '<C-Left>', '<C-o>b', opts)
keymap('i', '<C-Right>', '<C-o>w', opts)

-- 3. DÉSACTIVER le scroll par défaut de CTRL+D/U pour laisser multicursor l'utiliser
keymap({ 'n', 'v', 'i' }, '<C-d>', '<nop>', { noremap = false })
keymap({ 'n', 'v', 'i' }, '<C-u>', '<nop>', { noremap = false })

-- 4. Désactive la suspension de Neovim avec CTRL+Z
keymap({ 'n', 'v', 'i' }, '<C-z>', '<nop>')
keymap({ 'n', 'v', 'i' }, '<C-S-z>', '<nop>')

-- 5. Ajouter une ligne vide en dessous (Shift + Entrée)
keymap("n", "<S-Enter>", "o<Esc>", { desc = "Insert blank line below" })

-- 6. Smart navigation for insert mode (auto-pairs like behavior for some chars)
local chars = { ',', '.', '!', '?', ';', ' ', '(', ')', '[', ']', '{', '}' }
for _, char in ipairs(chars) do
    keymap('i', char, char .. '<c-g>u', { noremap = true, silent = true })
end
