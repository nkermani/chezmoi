-- dependencies:
-- - neovim with luajit support
-- - git >=2.19.0
-- - a nerdfont, can be fixed (bottom of https://lazy.folke.io/configuration)
-- optional:
-- - lua
-- - luarocks
-- - ripgrep for telescope

if vim.loop.fs_stat("/etc/osquery/") then
	vim.g.host = "cluster"
elseif vim.loop.fs_stat("/mnt/c/") then
	vim.g.host = "windows"
elseif vim.loop.fs_stat("/nix/") then
	vim.g.host = "nixos"
else
	vim.g.host = "other"
end


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("", "<space>", "<nop>")

require("config.lazy")
require("config.options")
require("config.keybindings")

-- vim.cmd.colorscheme("carbonfox")
if vim.g.host == "cluster" then
	vim.cmd.colorscheme("gruvbox-material")
else
	-- vim.cmd.colorscheme("everforest")
	vim.cmd.colorscheme("tokyonight")
end

