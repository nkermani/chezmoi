vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local ft = vim.bo.filetype
        local skip = { "oil", "dashboard", "telescope", "Trouble", "qf" }
        for _, s in ipairs(skip) do
            if ft == s then return end
        end
        
        vim.schedule(function()
            if vim.bo.filetype ~= "oil" then
                pcall(function() require("no-neck-pain").enable() end)
            end
        end)
    end,
})
