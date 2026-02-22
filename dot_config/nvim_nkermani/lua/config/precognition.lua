local ok, precognition = pcall(require, "precognition")
if not ok then return end

precognition.setup({
    startVisible = true,
    showBlankVirtLine = true,
    highlightColor = { link = "Comment" },
    hints = {
         Caret = { text = "^", prio = 2 },
         Dollar = { text = "$", prio = 1 },
         MatchingPair = { text = "%", prio = 5 },
         Zero = { text = "0", prio = 1 },
         w = { text = "w", prio = 10 },
         b = { text = "b", prio = 10 },
         e = { text = "e", prio = 10 },
         ge = { text = "ge", prio = 10 },
         W = { text = "W", prio = 9 },
         B = { text = "B", prio = 9 },
         E = { text = "E", prio = 9 },
         gE = { text = "gE", prio = 9 },
    },
    gutterHints = {
        G = { text = "G", prio = 10 },
        gg = { text = "gg", prio = 10 },
        PrevParagraph = { text = "{", prio = 8 },
        NextParagraph = { text = "}", prio = 8 },
    },
})

vim.keymap.set("n", "<leader>tp", function()
    local ok, precognition = pcall(require, "precognition")
    if ok then
        precognition.toggle()
        local status = precognition.is_visible and "ON" or "OFF"
        vim.notify("Precognition " .. status, vim.log.levels.INFO, { title = "Precognition" })
    end
end, { desc = "Toggle Precognition" })
