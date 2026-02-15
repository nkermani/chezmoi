local M = {}

M.colors = {
    bg = "#1e1e1e",
    fg = "#cacaca",
    red = "#f3505c",
    green = "#51f66f",
    yellow = "#eedb85",
    blue = "#368aec",
    magenta = "#d867c6",
    cyan = "#00f0ff",
    orange = "#ffc07a",
    comment = "#777777",
    cursor_line = "#2a2a2a",
    line_nr = "#676767",
    visual = "#3e4452",
    border = "#444444",
    sidebar_bg = "#252526",
    error_bg = "#603336",
    search_bg = "#A379D9",
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
    hl(0, "VertSplit", { fg = c.gold, bg = "none" })
    hl(0, "WinSeparator", { fg = c.gold, bg = "none" })
    hl(0, "StatusLine", { bg = c.sidebar_bg, fg = c.fg })
    hl(0, "StatusLineNC", { bg = c.sidebar_bg, fg = c.comment })
    hl(0, "FloatBorder", { fg = c.gold, bg = c.sidebar_bg })
    hl(0, "FloatTitle", { fg = c.gold, bg = c.sidebar_bg, bold = true })

    hl(0, "EdgyWinBar", { bg = c.sidebar_bg, fg = c.fg })
    hl(0, "EdgyWinBarNC", { bg = c.sidebar_bg, fg = c.comment })
    hl(0, "EdgyTitle", { fg = c.cyan, bold = true })
    hl(0, "EdgyIcon", { fg = c.cyan })
    hl(0, "EdgyIconActive", { fg = c.magenta })

    hl(0, "NoiceCmdlinePopupBorder", { fg = c.gold })
    hl(0, "NoiceCmdlinePopupTitle", { fg = c.gold })
    hl(0, "SnacksNotifierBorder", { fg = c.gold })
    hl(0, "SnacksNotifierTitle", { fg = c.gold })
    hl(0, "SnacksPickerBorder", { fg = c.gold })
    hl(0, "SnacksPickerTitle", { fg = c.gold })

    -- Bufferline / TabLine
    hl(0, "TabLine", { bg = c.sidebar_bg, fg = c.line_nr })
    hl(0, "TabLineFill", { bg = c.sidebar_bg })
    hl(0, "TabLineSel", { bg = c.bg, fg = c.fg, bold = true })
    hl(0, "BufferLineFill", { bg = c.sidebar_bg })
    hl(0, "BufferLineBackground", { bg = c.sidebar_bg, fg = c.line_nr })
end

return M
