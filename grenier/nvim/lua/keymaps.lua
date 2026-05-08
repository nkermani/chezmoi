-- ====== KEYMAPS ======
local km = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Window navigation
km("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
km("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
km("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
km("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
km("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split vertical" })
km("n", "<leader>-", "<cmd>split<cr>", { desc = "Split horizontal" })

-- Search
km("n", "<C-f>", "/", { desc = "Search" })
km("v", "<C-f>", [[y/<C-r>"<CR>]], { desc = "Search visual selection" })
km("i", "<C-f>", "<ESC>/", { desc = "Search from Insert" })
km("n", "<Esc>", "<cmd>noh<cr><Esc>", { desc = "Clear search highlights" })
km("n", "<leader>nl", function()
  vim.opt.number = not vim.opt.number:get()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle Line Numbers" })
km("n", "<leader>td", function()
  local is_enabled = vim.diagnostic.is_enabled()
  vim.diagnostic.enable(not is_enabled)
  local status = is_enabled and "OFF" or "ON"
  vim.notify("Diagnostics " .. status, vim.log.levels.INFO, { title = "LSP Diagnostics" })
end, { desc = "Toggle Diagnostics" })

-- Scroll
km({ 'n', 'i', 'v' }, '<M-ScrollWheelDown>', '15<C-e>', opts)
km({ 'n', 'i', 'v' }, '<M-ScrollWheelUp>', '15<C-y>', opts)
km({ 'n', 'i', 'v' }, '<S-ScrollWheelDown>', '5zh', opts)
km({ 'n', 'i', 'v' }, '<S-ScrollWheelUp>', '5zl', opts)

-- Visual / Quit
km('n', '<leader>v', '<C-v>', { desc = "Visual Block Mode" })
km({ 'n', 'i', 'v' }, '<C-q>', function()
  local bufs = vim.fn.filter(range(1, bufnr('$')), 'bufexists(v:val) && buflisted(v:val)')
  if #bufs > 1 then vim.cmd("bd!") else vim.cmd("qa") end
end, { desc = "Smart Quit" })
km({ 'n', 'i', 'v' }, '<C-S-q>', ':qa!<CR>', { desc = "Force Quit All" })
km("n", "q:", "<nop>", opts)
km("n", "q/", "<nop>", opts)
km("n", "q?", "<nop>", opts)
km("v", "q:", "<nop>", opts)

-- Indentation
km("v", "<Tab>", ">gv", { desc = "Indent selection" })
km("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })
km("n", "<Tab>", ">>", { desc = "Indent line" })
km("n", "<S-Tab>", "<<", { desc = "Unindent line" })
km("i", "<S-Tab>", "<C-d>", { desc = "Unindent line" })

-- Move lines
km('n', '<M-Down>', function() if vim.bo.modifiable then vim.cmd('m .+1') vim.cmd('normal! ==') end end, opts)
km('n', '<M-Up>', function() if vim.bo.modifiable then vim.cmd('m .-2') vim.cmd('normal! ==') end end, opts)
km('i', '<M-Down>', function() if vim.bo.modifiable then vim.cmd('normal! <Esc>') vim.cmd('m .+1') vim.cmd('normal! ==gi') end end, opts)
km('i', '<M-Up>', function() if vim.bo.modifiable then vim.cmd('normal! <Esc>') vim.cmd('m .-2') vim.cmd('normal! ==gi') end end, opts)
km('v', '<M-Down>', function() if vim.bo.modifiable then vim.cmd("m '>+1") vim.cmd('normal! gv=gv') end end, opts)
km('v', '<M-Up>', function() if vim.bo.modifiable then vim.cmd("m '<-2") vim.cmd('normal! gv=gv') end end, opts)
km('n', '<S-M-Down>', function() if vim.bo.modifiable then vim.cmd('normal! yyp') end end, opts)
km('n', '<S-M-Up>', function() if vim.bo.modifiable then vim.cmd('normal! yyP') end end, opts)
km('i', '<S-M-Down>', function() if vim.bo.modifiable then vim.cmd('normal! <Esc>yypgi') end end, opts)
km('i', '<S-M-Up>', function() if vim.bo.modifiable then vim.cmd('normal! <Esc>yyPgi') end end, opts)
km('v', '<S-M-Down>', function() if vim.bo.modifiable then vim.cmd('normal! yPgv') end end, opts)
km('v', '<S-M-Up>', function() if vim.bo.modifiable then vim.cmd('normal! yPgv') end end, opts)

-- Delete / Backspace
km('i', '<M-BS>', '<C-u>', { desc = "Delete to start of line" })
km('n', '<M-BS>', function() if vim.bo.modifiable then vim.cmd('normal! d^') end end, { desc = "Delete to start of line" })
km('i', '<M-Delete>', '<C-o>D', { desc = "Delete to end of line" })
km('n', '<M-Delete>', function() if vim.bo.modifiable then vim.cmd('normal! D') end end, { desc = "Delete to end of line" })
km('i', '<C-BS>', '<C-w>', opts)
km('i', '<C-H>', '<C-w>', opts)
km('n', '<C-BS>', function() if vim.bo.modifiable then vim.cmd('normal! db') end end, opts)
km('n', '<C-H>', function() if vim.bo.modifiable then vim.cmd('normal! db') end end, opts)
km('v', '<C-BS>', '"_d', opts)
km('v', '<C-H>', '"_d', opts)
km("n", "<C-Delete>", function() if vim.bo.modifiable then vim.cmd('normal! dw') end end, { desc = "Delete word forward" })
km("i", "<C-Delete>", "<C-o>dw", { desc = "Delete word forward in insert mode" })

-- Backspace / Delete / Enter
km('n', '<BS>', function()
  if not vim.bo.modifiable then vim.cmd('normal! h'); return end
  if vim.fn.col('.') == 1 then
    if vim.fn.line('.') > 1 then vim.cmd('normal! kgJ') end
  else vim.cmd('normal! x') end
end, { desc = "Backspace" })
km('n', '<Del>', function()
  if not vim.bo.modifiable then return end
  local line = vim.fn.getline('.')
  if #line == 0 or vim.fn.col('.') >= #line then vim.cmd('normal! gJ')
  else vim.cmd('normal! x') end
end, { desc = "Delete" })
km('n', '<CR>', function()
  if not vim.bo.modifiable then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
    return
  end
  vim.cmd('normal! i\\13\\27')
end, { desc = "Enter splits line" })

-- Comments
km('n', '<C-_>', 'gcc', { remap = true, desc = "Comment line" })
km('n', '<C-/>', 'gcc', { remap = true, desc = "Comment line" })
km('i', '<C-_>', '<Esc>gccai', { remap = true, desc = "Comment line" })
km('i', '<C-/>', '<Esc>gccai', { remap = true, desc = "Comment line" })
km('v', '<C-_>', 'gc', { remap = true, desc = "Comment selection" })
km('v', '<C-/>', 'gc', { remap = true, desc = "Comment selection" })

-- Undo / Redo
km("n", "<C-z>", "u", { desc = "Undo" })
km("n", "<C-y>", "<C-r>", { desc = "Redo" })
km("i", "<C-z>", "<C-o>u", { desc = "Undo" })
km("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })
km("v", "<C-z>", "<Esc>ugv", { desc = "Undo" })
km("v", "<C-y>", "<Esc><C-r>gv", { desc = "Redo" })

-- Black hole register
km({ "n", "v" }, "x", '"_x', opts)
km({ "n", "v" }, "d", '"_d', opts)
km({ "n", "v" }, "D", '"_D', opts)
km({ "n", "v" }, "c", '"_c', opts)
km({ "n", "v" }, "C", '"_C', opts)
km("v", "<BS>", '"_d', opts)
km("x", "p", function()
  if vim.bo.modifiable then vim.cmd('normal! "_dP') else vim.cmd('normal! y') end
end, { desc = "Paste without overwriting register" })

-- Navigation
km('n', '<M-Left>', '^', opts)
km('n', '<M-Right>', '$', opts)
km('n', '<Home>', '^', opts)
km('n', '<End>', '$', opts)
km('i', '<M-Left>', '<C-o>^', opts)
km('i', '<M-Right>', '<C-o>$', opts)
km('i', '<Home>', '<C-o>^', opts)
km('i', '<End>', '<C-o>$', opts)
km('v', '<M-Left>', '^', opts)
km('v', '<M-Right>', '$', opts)
km('v', '<Home>', '^', opts)
km('v', '<End>', '$', opts)
km({ 'n', 'v' }, '<C-Left>', 'b', opts)
km({ 'n', 'v' }, '<C-Right>', 'w', opts)
km('i', '<C-Left>', '<C-o>b', opts)
km('i', '<C-Right>', '<C-o>w', opts)
km({ 'n', 'v', 'i' }, '<C-d>', '<nop>', { noremap = false })
km({ 'n', 'v', 'i' }, '<C-u>', '<nop>', { noremap = false })
km({ 'n', 'v', 'i' }, '<C-z>', '<nop>')
km({ 'n', 'v', 'i' }, '<C-S-z>', '<nop>')
km("n", "<S-Enter>", "o<Esc>", { desc = "Insert blank line below" })

-- Selection
km("n", "<S-Up>", "v<Up>", { desc = "Select Up" })
km("n", "<S-Down>", "v<Down>", { desc = "Select Down" })
km("n", "<S-Left>", "v<Left>", { desc = "Select Left" })
km("n", "<S-Right>", "v<Right>", { desc = "Select Right" })
km("v", "<S-Up>", "<Up>", { desc = "Extend Up" })
km("v", "<S-Down>", "<Down>", { desc = "Extend Down" })
km("v", "<S-Left>", "<Left>", { desc = "Extend Left" })
km("v", "<S-Right>", "<Right>", { desc = "Extend Right" })
km("i", "<S-Up>", "<Esc>v<Up>", { desc = "Select Up" })
km("i", "<S-Down>", "<Esc>v<Down>", { desc = "Select Down" })
km("i", "<S-Left>", "<Esc>v<Left>", { desc = "Select Left" })
km("i", "<S-Right>", "<Esc>v<Right>", { desc = "Select Right" })
km("n", "<C-S-Left>", "vb", { desc = "Select Word Left" })
km("n", "<C-S-Right>", "vw", { desc = "Select Word Right" })
km("v", "<C-S-Left>", "b", { desc = "Extend Word Left" })
km("v", "<C-S-Right>", "w", { desc = "Extend Word Right" })
km("i", "<C-S-Left>", "<Esc>vb", { desc = "Select Word Left" })
km("i", "<C-S-Right>", "<Esc>vw", { desc = "Select Word Right" })
km("n", "<M-S-Left>", "v^", { desc = "Select to Start of Line" })
km("n", "<M-S-Right>", "v$", { desc = "Select to End of Line" })
km("v", "<M-S-Left>", "^", { desc = "Extend to Start of Line" })
km("v", "<M-S-Right>", "$", { desc = "Extend to End of Line" })
km("i", "<M-S-Left>", "<Esc>v^", { desc = "Select to Start of Line" })
km("i", "<M-S-Right>", "<Esc>v$", { desc = "Select to End of Line" })
km({ 'n', 'i', 'v' }, '<C-a>', 'ggVG', { desc = "Select All", noremap = true })
km('n', '<C-l>', 'V', { desc = "Select line" })
km('i', '<C-l>', '<Esc>V', { desc = "Select line" })
km('v', '<C-l>', 'j', { desc = "Extend selection" })

-- Wrap selection keymaps
km("x", "(", wrap_selection("(", ")"), { desc = "Wrap with ()", nowait = true })
km("x", "{", wrap_selection("{", "}"), { desc = "Wrap with {}", nowait = true })
km("x", '"', wrap_selection('"', '"'), { desc = 'Wrap with ""', nowait = true })
km("x", "'", wrap_selection("'", "'"), { desc = "Wrap with ''''", nowait = true })
km("x", "`", wrap_selection("`", "`"), { desc = "Wrap with ``", nowait = true })

-- Mouse
km("n", "<C-LeftMouse>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
km("n", "<C-M-LeftMouse>", function()
  require('telescope.builtin').lsp_references({
    layout_strategy = 'cursor',
    layout_config = { width = 0.6, height = 0.4 },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  })
end, { desc = "Peek references" })
km('n', '<2-LeftMouse>', 'viw', opts)
km('n', '<3-LeftMouse>', 'V', opts)

vim.cmd([[
  amenu PopUp.Split\\ Vertical <cmd>vsplit<CR>
  amenu PopUp.Split\\ Horizontal <cmd>split<CR>
  amenu PopUp.Kill\\ Buffer <cmd>lua _G.smart_close()<CR>
  amenu PopUp.Add\\ to\\ Multi-Selection <Plug>(VM-Visual-Cursors)
  amenu PopUp.Copy\\ (Multi) y
  amenu PopUp.Quit\\ Neovim <cmd>qa<CR>
  amenu PopUp.-1- *
  amenu PopUp.Definition <cmd>lua vim.lsp.buf.definition()<CR>
  amenu PopUp.References <cmd>lua require('telescope.builtin').lsp_references({ layout_strategy = 'cursor', layout_config = { width = 0.6, height = 0.4 } })<CR>
  amenu PopUp.Rename <cmd>lua vim.lsp.buf.rename()<CR>
  amenu PopUp.-2- *
  amenu PopUp.Format <cmd>lua vim.lsp.buf.format()<CR>
]])

-- Plugin keymaps
km("n", "<leader>y", ":Yazi<CR>", { desc = "Open Yazi file manager" })
km({ 'n', 'v', 'i' }, "<C-p>", ":Telescope commands<CR>", { desc = "Command Palette" })
km({ 'n', 'v', 'i' }, "<C-S-p>", ":Telescope commands<CR>", { desc = "Command Palette" })
km("n", "fw", ":Telescope live_grep<CR>", { desc = "Search text in project" })
km("n", "<C-S-f>", ":Telescope live_grep<CR>", { desc = "Search text in project" })
km("n", "ff", ":Telescope find_files<CR>", { desc = "Telescope find files" })
km("n", "fg", ":Telescope live_grep<CR>", { desc = "Telescope live grep" })
km("n", "fb", ":Telescope buffers<CR>", { desc = "Telescope buffers" })
km("n", "fs", ":Telescope grep_string<CR>", { desc = "Find current word" })
km("n", "fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })
km("n", "fk", ":Telescope keymaps<CR>", { desc = "Show keymaps" })
km("n", "ft", ":Telescope help_tags<CR>", { desc = "Telescope help tags" })
km("n", "fh", function()
  require("telescope.builtin").find_files({ cwd = "~", prompt_title = "Search in Home (~)", hidden = true })
end, { desc = "Telescope find files in HOME" })
km("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
km("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })
km({ "n", "i", "v" }, "<M-w>", function() _G.smart_close() end, { desc = "Smart Close (Pane or Buffer)" })
km("n", "<leader>x", function() _G.smart_close() end, { desc = "Smart Close (Pane or Buffer)" })
km("n", "<leader>tp", function()
  local ok, precognition = pcall(require, "precognition")
  if ok then
    precognition.toggle()
    local status = precognition.is_visible and "ON" or "OFF"
    vim.notify("Precognition " .. status, vim.log.levels.INFO, { title = "Precognition" })
  end
end, { desc = "Toggle Precognition" })
km("n", "<leader>z", function() require("snacks").zen() end, { desc = "Toggle Zen Mode" })
km("n", "<leader>Z", function() require("snacks").zen.zoom() end, { desc = "Toggle Zoom Mode" })
km("n", "<leader>bd", function() require("snacks").bufdelete() end, { desc = "Delete Buffer" })
km("n", "<leader>nh", function() require("snacks").notifier.show_history() end, { desc = "Notification History" })
km("n", "<leader>rn", function() require("snacks").rename.rename_file() end, { desc = "Rename File" })

-- Terminal keymaps
local function set_terminal_keymaps()
  local opts = { buffer = true }
  km('t', '<esc>', [[<C-\\><C-n>]], opts)
  km('t', 'jk', [[<C-\\><C-n>]], opts)
  km('t', '<C-h>', [[<C-\\><C-n><C-w>h]], opts)
  km('t', '<C-j>', [[<C-\\><C-n><C-w>j]], opts)
  km('t', '<C-k>', [[<C-\\><C-n><C-w>k]], opts)
  km('t', '<C-l>', [[<C-\\><C-n><C-w>l]], opts)
  km('t', '<C-w>', [[<C-\\><C-n><C-w>]], opts)
end
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*',
  callback = set_terminal_keymaps,
})

-- Oil keymaps
km("n", "-", function()
  if vim.bo.filetype == "oil" then require("oil").open("..")
  else
    local nt_api = pcall(require, "neo-tree.command")
    if nt_api then require("neo-tree.command").execute({ action = "close" }) end
    vim.cmd("Oil")
  end
end, { desc = "Go up in Oil or Open Oil (closing Neo-tree)" })
km("n", "_", "<CMD>Oil .<CR>", { desc = "Open Oil in CWD" })

-- Neo-tree toggle
km('n', '<leader>e', function()
  if vim.bo.filetype == "oil" then
    require("oil").close()
    vim.cmd("Neotree show"); return
  end
  vim.cmd("Neotree toggle")
end, { desc = "Toggle Neo-tree" })

-- Conform toggle
km("n", "<leader>tf", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  local status = vim.g.disable_autoformat and "OFF" or "ON"
  vim.notify("Format on Save " .. status, vim.log.levels.INFO, { title = "Conform" })
end, { desc = "Toggle Format on Save" })
