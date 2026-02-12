vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local arg = vim.fn.argv(0)
        
        if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
            vim.schedule(function()
                if vim.bo.filetype == "oil" then
                    vim.cmd("bwipeout!")
                end
                require("oil").toggle_float(arg)
            end)
        end
    end,
})

