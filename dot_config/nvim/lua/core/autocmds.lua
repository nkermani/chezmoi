-- Mouse Hover (Style IDE) : Affiche la documentation LSP au survol de la souris
local hover_timer = vim.loop.new_timer()
vim.api.nvim_create_autocmd("MouseMove", {
    callback = function()
        hover_timer:stop()
        hover_timer:start(500, 0, vim.schedule_wrap(function()
            local mouse = vim.fn.getmousepos()
            if mouse.winid > 0 and mouse.winid == vim.api.nvim_get_current_win() then
                local row, col = mouse.line, mouse.column
                vim.api.nvim_win_set_cursor(0, { row, col - 1 })
                vim.lsp.buf.hover()
            end
        end))
    end,
})
