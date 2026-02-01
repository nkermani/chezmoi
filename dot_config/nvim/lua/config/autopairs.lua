-- lua/config/autopairs.lua
-- windwp/nvim-autopairs.nvim -> Plugin to directly pair brackets, parenthesis

require("nvim-autopairs").setup({})

-- Integration with nvim-cmp: auto-add brackets on function completion
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())


