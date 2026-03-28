-- lua/config/autopairs.lua
-- windwp/nvim-autopairs.nvim -> Plugin to directly pair brackets, parenthesis

require("nvim-autopairs").setup({
    check_ts = true,
    enable_check_bracket_line = true,
    enable_afterquote = true,
    enable_moveright = true,
    fast_wrap = {},
})


-- Integration with nvim-cmp: auto-add brackets on function completion
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())


