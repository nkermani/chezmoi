local M = {}

M.colors = {
    bg = "#212121",
    fg = "#cacaca",
    red = "#f3505c",
    green = "#51f66f",
    yellow = "#eedb85",
    blue = "#368aec",
    magenta = "#d867c6",
    cyan = "#00f0ff",
    orange = "#ff9e64",
    comment = "#777777",
    cursor_line = "#2a2a2a",
    line_nr = "#676767",
    visual = "#3e4452",
    border = "#f3505c",
    sidebar_bg = "#1a1a1a",
    error_bg = "#603336",
    search_bg = "#d867c6",
    gold = "#ffcc00",
}

function M.setup()
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    vim.o.termguicolors = true
    vim.g.colors_name = "cyberpunk_nk"

    local c = M.colors
    local hl = vim.api.nvim_set_hl

    -- Base
    hl(0, "Normal", { fg = c.fg, bg = c.bg })
    hl(0, "NormalFloat", { fg = c.fg, bg = c.sidebar_bg })
    hl(0, "Cursor", { fg = c.bg, bg = c.fg })
    hl(0, "CursorLine", { bg = c.cursor_line })
    hl(0, "LineNr", { fg = c.line_nr })
    hl(0, "CursorLineNr", { fg = c.cyan, bold = true })
    hl(0, "Visual", { bg = c.visual })
    hl(0, "SignColumn", { bg = c.bg })
    hl(0, "VertSplit", { fg = c.border, bg = "none" })
    hl(0, "WinSeparator", { fg = c.border, bg = "none" })
    hl(0, "StatusLine", { bg = c.sidebar_bg, fg = c.fg })
    hl(0, "StatusLineNC", { bg = c.sidebar_bg, fg = c.comment })
    hl(0, "FloatBorder", { fg = c.border, bg = c.sidebar_bg })
    hl(0, "FloatTitle", { fg = c.border, bg = c.sidebar_bg, bold = true })

    -- Edgy
    hl(0, "EdgyWinBar", { bg = c.sidebar_bg, fg = c.fg })
    hl(0, "EdgyWinBarNC", { bg = c.sidebar_bg, fg = c.comment })
    hl(0, "EdgyTitle", { fg = c.cyan, bold = true })
    hl(0, "EdgyIcon", { fg = c.cyan })
    hl(0, "EdgyIconActive", { fg = c.magenta })

    -- Floating Windows & Noice
    hl(0, "FloatBorder", { fg = c.border, bg = c.sidebar_bg })
    hl(0, "NoiceCmdlinePopupBorder", { fg = c.red })
    hl(0, "NoiceCmdlinePopupTitle", { fg = c.red })
    hl(0, "SnacksNotifierBorder", { fg = c.gold })
    hl(0, "SnacksNotifierTitle", { fg = c.gold })
    hl(0, "SnacksPickerBorder", { fg = c.red })
    hl(0, "SnacksPickerTitle", { fg = c.red })

    -- Cmp
    hl(0, "CmpItemAbbrMatch", { fg = c.cyan, bold = true })
    hl(0, "CmpItemAbbrMatchFuzzy", { fg = c.cyan, bold = true })
    hl(0, "CmpItemKindFunction", { fg = c.blue })
    hl(0, "CmpItemKindMethod", { fg = c.blue })
    hl(0, "CmpItemKindVariable", { fg = c.fg })
    hl(0, "CmpItemKindKeyword", { fg = c.red })

    -- Alpha
    hl(0, "AlphaHeader", { fg = c.cyan, bold = true })
    hl(0, "AlphaButton", { fg = c.fg })
    hl(0, "AlphaButtonShortcut", { fg = c.red, bold = true })

    -- Syntax
    hl(0, "Comment", { fg = c.comment, italic = true })
    hl(0, "Constant", { fg = c.magenta })
    hl(0, "String", { fg = c.yellow })
    hl(0, "Character", { fg = c.yellow })
    hl(0, "Number", { fg = c.blue })
    hl(0, "Boolean", { fg = c.magenta })
    hl(0, "Float", { fg = c.blue })

    hl(0, "Identifier", { fg = c.fg })
    hl(0, "Function", { fg = c.cyan })

    hl(0, "Statement", { fg = c.red })
    hl(0, "Conditional", { fg = c.red })
    hl(0, "Repeat", { fg = c.red })
    hl(0, "Label", { fg = c.red })
    hl(0, "Operator", { fg = c.fg })
    hl(0, "Keyword", { fg = c.red })
    hl(0, "Exception", { fg = c.red })

    hl(0, "PreProc", { fg = c.orange })
    hl(0, "Include", { fg = c.red })
    hl(0, "Define", { fg = c.red })
    hl(0, "Macro", { fg = c.orange })

    hl(0, "Type", { fg = c.green })
    hl(0, "StorageClass", { fg = c.red })
    hl(0, "Structure", { fg = c.red })
    hl(0, "Typedef", { fg = c.red })

    hl(0, "Special", { fg = c.magenta })
    hl(0, "SpecialChar", { fg = c.magenta })

    -- Treesitter
    hl(0, "@variable", { fg = c.fg })
    hl(0, "@variable.builtin", { fg = c.red })
    hl(0, "@property", { fg = c.fg })
    hl(0, "@field", { fg = c.fg })
    hl(0, "@parameter", { fg = c.fg })
    hl(0, "@function", { fg = c.cyan })
    hl(0, "@function.builtin", { fg = c.cyan })
    hl(0, "@method", { fg = c.cyan })
    hl(0, "@keyword", { fg = c.red })
    hl(0, "@keyword.function", { fg = c.red })
    hl(0, "@string", { fg = c.yellow })
    hl(0, "@type", { fg = c.green })
    hl(0, "@type.builtin", { fg = c.green })
    hl(0, "@constructor", { fg = c.green })
    hl(0, "@operator", { fg = c.fg })
    hl(0, "@punctuation", { fg = c.fg })

    -- Bufferline / TabLine
    hl(0, "TabLine", { bg = c.sidebar_bg, fg = c.line_nr })
    hl(0, "TabLineFill", { bg = c.sidebar_bg })
    hl(0, "TabLineSel", { bg = c.bg, fg = c.cyan, bold = true })
    hl(0, "BufferLineFill", { bg = c.sidebar_bg })
    hl(0, "BufferLineBackground", { bg = c.sidebar_bg, fg = c.line_nr })
end

return M

