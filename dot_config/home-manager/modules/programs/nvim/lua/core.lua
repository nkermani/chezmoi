-- ====== LEADER ======
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ====== OPTIONS ======
if vim.fn.has("unix") == 1 then
  local undodir = os.getenv("HOME") .. "/.vim/undodir"
  if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
  end
  vim.opt.undodir = undodir
  vim.opt.undofile = true
end

vim.opt.endofline = true
vim.opt.fixendofline = true
vim.opt.mouse = "a"
vim.opt.mousemodel = "popup"
vim.opt.mousemoveevent = true
vim.opt.selection = "inclusive"
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes:2"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = " ", vert = "│", horiz = "─", diff = "╱", fold = " ", msgsep = "‾", foldopen = "", foldsep = "│", foldclose = "" }
vim.opt.laststatus = 3
vim.opt.wrap = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 100
vim.opt.scrolloff = 8
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = "unnamedplus"

-- ====== SMART CLOSE ======
_G.smart_close = function()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local normal_wins = {}
  for _, win in ipairs(wins) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative == "" then
      table.insert(normal_wins, win)
    end
  end
  if #normal_wins > 1 then
    vim.cmd("close")
  else
    require("snacks").bufdelete()
  end
end

vim.opt.winbar = "%=%#WinBar#%@v:lua.smart_close@ 󰅖 %*"

-- ====== WRAP SELECTION ======
local function wrap_selection(open, close)
  return function()
    if not vim.bo.modifiable then return end
    local mode = vim.fn.mode()
    local save_reg = vim.fn.getreg('v')
    local save_regtype = vim.fn.getregtype('v')
    vim.cmd('normal! "vy')
    local text = vim.fn.getreg('v')
    if mode == 'V' then text = open .. text:gsub('\\n$', "") .. close .. '\\n'
    else text = open .. text .. close end
    vim.fn.setreg('v', text)
    vim.cmd('normal! gv"vp')
    vim.cmd('normal! `[v`]')
    vim.fn.setreg('v', save_reg, save_regtype)
  end
end
