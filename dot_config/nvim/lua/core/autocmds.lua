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
