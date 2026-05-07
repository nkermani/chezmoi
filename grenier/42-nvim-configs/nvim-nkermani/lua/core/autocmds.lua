-- lua/core/autocmds.lua

-- 1. AUTO-OPEN NEO-TREE
-- Ouvre Neo-tree automatiquement lors de l'ouverture d'un fichier (ex: depuis Oil)
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local ft = vim.bo.filetype
        local skip = { "oil", "dashboard", "telescope", "Trouble", "qf", "neo-tree", "alpha" }
        for _, s in ipairs(skip) do
            if ft == s then return end
        end
        
        -- Ignore special buffers, floating windows, or directories
        if vim.bo.buftype ~= "" or vim.api.nvim_win_get_config(0).relative ~= "" or vim.fn.isdirectory(vim.fn.expand("%:p")) ~= 0 then
            return
        end

        local ok, nt_command = pcall(require, "neo-tree.command")
        if ok then
            local manager = require("neo-tree.sources.manager")
            local state = manager.get_state("filesystem")
            if not state.winid or not vim.api.nvim_win_is_valid(state.winid) then
                vim.schedule(function()
                    -- Re-check validity inside schedule to avoid E242 (Can't split while closing)
                    if not state.winid or not vim.api.nvim_win_is_valid(state.winid) then
                        pcall(nt_command.execute, { action = "show", source = "filesystem", position = "left" })
                    end
                end)
            end
        end
    end,
})

-- 2. MOUSE HOVER (Style IDE)
-- Affiche la documentation LSP au survol de la souris (500ms de délai)
local hover_timer = vim.loop.new_timer()
vim.keymap.set({ "n", "i", "v" }, "<MouseMove>", function()
    hover_timer:stop()
    hover_timer:start(500, 0, vim.schedule_wrap(function()
        local mouse = vim.fn.getmousepos()
        if mouse.winid > 0 and mouse.winid == vim.api.nvim_get_current_win() then
            local row, col = mouse.line, mouse.column
            -- vim.lsp.buf.hover() -- Commenté pour éviter les popups intempestifs
        end
    end))
end, { silent = true })
