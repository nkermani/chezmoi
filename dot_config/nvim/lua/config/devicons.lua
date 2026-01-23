-- lua/config/devicons.lua
-- nvim-tree/nvim-web-devicons -> Provides Nerd Font Icons
local ok, devicons = pcall(require, "nvim-web-devicons")
if not ok then return end

devicons.setup({ default = true })
