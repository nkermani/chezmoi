vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local ft = vim.bo.filetype
        local skip = { "oil", "dashboard", "telescope", "Trouble", "qf", "neo-tree", "alpha" }
        for _, s in ipairs(skip) do
            if ft == s then return end
        end
        
        if vim.fn.isdirectory(vim.fn.expand("%:p")) == 0 and vim.bo.buftype == "" then
            local nt_api = pcall(require, "neo-tree.command")
            if nt_api then
                local manager = require("neo-tree.sources.manager")
                local state = manager.get_state("filesystem")
                if not state.winid or not vim.api.nvim_win_is_valid(state.winid) then
                    require("neo-tree.command").execute({ action = "show", source = "filesystem", position = "left" })
                end
            end
        end
    end,
})
