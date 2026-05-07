require("vim._core.ui2").enable({})
vim.cmd("packadd nvim.undotree")
vim.cmd("packadd nvim.tohtml")
vim.cmd("packadd nvim.difftool")

vim.opt.termguicolors = true

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

vim.opt.timeoutlen = 500

vim.opt.clipboard:append("unnamedplus")
vim.opt.mousemodel = "extend"

vim.opt.winborder = "rounded"

vim.opt.list = true
vim.opt.listchars = {
	lead = "·",
	trail = "·",
	nbsp = "·",
	tab = "» ",
	extends = "›",
	precedes = "‹"
}

-- if vim.g.host == "home" then
-- 	vim.opt.langmap = { "&1", "é2", "\"3", "'4", "(5", "-6", "è7", "_8", "ç9", "à0" }
-- end

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function() vim.highlight.on_yank() end
})



--[[
" MAYBE
autoindent
cindent
" USELESS
set nowrap
set conceallevel=1
set updatetime=300
let g:vim_markdown_frontmatter = 1
let g:zig_fmt_autosave = 0
"
]]



-- if vim.g.host == "cluster" then
-- 	vim.cmd.source("/usr/share/vim/vim85/plugin/stdheader.vim")
-- end


-- TRASH

vim.filetype.add({ extension = { cl = "c" } })
vim.filetype.add({ extension = { h = "c" } })

if vim.g.host == "cluster" then

vim.cmd [[

let g:c_formatter_42_exec           = get(g:, 'c_formatter_42_exec', 'c_formatter_42')
let g:c_formatter_42_set_equalprg   = get(g:, 'c_formatter_42_set_equalprg', 0)
let g:c_formatter_42_format_on_save = get(g:, 'c_formatter_42_format_on_save', 0)

if !executable(g:c_formatter_42_exec)
echom 'Installing c_formatter_42'
!pip3 install --user --break-system-packages c-formatter-42
endif

function! s:CFormatter42()
normal! mq
let l:equalprg_tmp = &equalprg
let &equalprg = g:c_formatter_42_exec
silent normal! gg=G
let &equalprg = l:equalprg_tmp
normal! `q
normal! zz
endfunction

if g:c_formatter_42_set_equalprg
let &l:equalprg = g:c_formatter_42_exec
endif

augroup c_formatter_42
autocmd!
autocmd FileType c,cpp,h,hpp command! CFormatter42 call s:CFormatter42()
augroup END

]]

end
