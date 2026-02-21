---@diagnostic disable: undefined-global
-- [[ --------------------- KEYMAP OVERVIEW --------------------- ]]
--
-- Leader key: "," (comma)
--
-- ---------------------------------------------------------------
--  Mouse Experience
-- ---------------------------------------------------------------
--   <C-LeftMouse>   (n) : Go to definition
--   <C-M-LeftMouse> (n) : Peek references (Telescope)
--   <2-LeftMouse>   (n) : Select word
--   <3-LeftMouse>   (n) : Select line
--   Right Click         : Context Menu (Split, Rename, Format, etc.)
--
-- [[ ----------------------------------------------------------- ]]
-- lua/core/keymaps/mouse.lua
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- MOUSE EXPERIENCE (Style IDE)
-- CTRL + Clic Gauche : Aller à la définition
keymap("n", "<C-LeftMouse>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
keymap("n", "<C-M-LeftMouse>", function()
    require('telescope.builtin').lsp_references({
        layout_strategy = 'cursor',
        layout_config = {
            width = 0.6,
            height = 0.4,
        },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    })
end, { desc = "Peek references" })
keymap('n', '<2-LeftMouse>', 'viw', opts)
-- Triple-clic : Sélectionne toute la ligne
keymap('n', '<3-LeftMouse>', 'V', opts)

-- Menu contextuel (Clic droit)
vim.cmd([[
  amenu PopUp.Split\ Vertical <cmd>vsplit<CR>
  amenu PopUp.Split\ Horizontal <cmd>split<CR>
  amenu PopUp.Kill\ Buffer <cmd>lua _G.smart_close()<CR>
  amenu PopUp.Add\ to\ Multi-Selection <Plug>(VM-Visual-Cursors)
  amenu PopUp.Copy\ (Multi) y
  amenu PopUp.Quit\ Neovim <cmd>qa<CR>
  amenu PopUp.-1- *
  amenu PopUp.Definition <cmd>lua vim.lsp.buf.definition()<CR>
  amenu PopUp.References <cmd>lua require('telescope.builtin').lsp_references({ layout_strategy = 'cursor', layout_config = { width = 0.6, height = 0.4 } })<CR>
  amenu PopUp.Rename <cmd>lua vim.lsp.buf.rename()<CR>
  amenu PopUp.-2- *
  amenu PopUp.Format <cmd>lua vim.lsp.buf.format()<CR>
]])
