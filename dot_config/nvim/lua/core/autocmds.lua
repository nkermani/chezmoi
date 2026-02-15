vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local ft = vim.bo.filetype
        local skip = { "oil", "dashboard", "telescope", "Trouble", "qf", "neo-tree" }
        for _, s in ipairs(skip) do
            if ft == s then return end
        end
        
        vim.schedule(function()
            if vim.bo.filetype ~= "oil" and vim.fn.isdirectory(vim.fn.expand("%:p")) == 0 then
                -- Open Neo-tree if it's a real file
                pcall(function() 
                    require("neo-tree.command").execute({ action = "show", source = "filesystem", position = "left" })
                end)
            end
        end)
    end,
})
