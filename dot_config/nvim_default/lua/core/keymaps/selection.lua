-- lua/core/keymaps/selection.lua
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- SHIFT + ARROWS (Select Characters/Lines)
keymap("n", "<S-Up>", "v<Up>", { desc = "Select Up" })
keymap("n", "<S-Down>", "v<Down>", { desc = "Select Down" })
keymap("n", "<S-Left>", "v<Left>", { desc = "Select Left" })
keymap("n", "<S-Right>", "v<Right>", { desc = "Select Right" })

keymap("v", "<S-Up>", "<Up>", { desc = "Extend Up" })
keymap("v", "<S-Down>", "<Down>", { desc = "Extend Down" })
keymap("v", "<S-Left>", "<Left>", { desc = "Extend Left" })
keymap("v", "<S-Right>", "<Right>", { desc = "Extend Right" })

keymap("i", "<S-Up>", "<Esc>v<Up>", { desc = "Select Up" })
keymap("i", "<S-Down>", "<Esc>v<Down>", { desc = "Select Down" })
keymap("i", "<S-Left>", "<Esc>v<Left>", { desc = "Select Left" })
keymap("i", "<S-Right>", "<Esc>v<Right>", { desc = "Select Right" })

-- CTRL + SHIFT + ARROWS (Select Word)
keymap("n", "<C-S-Left>", "vb", { desc = "Select Word Left" })
keymap("n", "<C-S-Right>", "vw", { desc = "Select Word Right" })
keymap("v", "<C-S-Left>", "b", { desc = "Extend Word Left" })
keymap("v", "<C-S-Right>", "w", { desc = "Extend Word Right" })
keymap("i", "<C-S-Left>", "<Esc>vb", { desc = "Select Word Left" })
keymap("i", "<C-S-Right>", "<Esc>vw", { desc = "Select Word Right" })

-- ALT + SHIFT + ARROWS (Select to Extremities)
keymap("n", "<M-S-Left>", "v^", { desc = "Select to Start of Line" })
keymap("n", "<M-S-Right>", "v$", { desc = "Select to End of Line" })
keymap("v", "<M-S-Left>", "^", { desc = "Extend to Start of Line" })
keymap("v", "<M-S-Right>", "$", { desc = "Extend to End of Line" })
keymap("i", "<M-S-Left>", "<Esc>v^", { desc = "Select to Start of Line" })
keymap("i", "<M-S-Right>", "<Esc>v$", { desc = "Select to End of Line" })

-- SÉLECTION TOTALE (CTRL + A)
keymap({ 'n', 'i', 'v' }, '<C-a>', 'ggVG', { desc = "Select All" })

-- SÉLECTION DE LIGNE (CTRL + L)
keymap('n', '<C-l>', 'V', { desc = "Select line" })
keymap('i', '<C-l>', '<Esc>V', { desc = "Select line" })
keymap('v', '<C-l>', 'j', { desc = "Extend selection" })

-- ===================================================================
-- WRAP SELECTION
-- ===================================================================
local function wrap_selection(open, close)
    return function()
        if not vim.bo.modifiable then return end
        local mode = vim.fn.mode()
        local save_reg = vim.fn.getreg('v')
        local save_regtype = vim.fn.getregtype('v')

        vim.cmd('normal! "vy')
        local text = vim.fn.getreg('v')

        if mode == 'V' then
            text = open .. text:gsub('\n$', '') .. close .. '\n'
        else
            text = open .. text .. close
        end

        vim.fn.setreg('v', text)
        vim.cmd('normal! gv"vp')
        vim.cmd('normal! `[v`]')

        vim.fn.setreg('v', save_reg, save_regtype)
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.keymap.set("x", "[", wrap_selection("[", "]"), { buffer = true, nowait = true, desc = "Wrap with []" })
    end,
})

keymap("x", "(", wrap_selection("(", ")"), { desc = "Wrap with ()", nowait = true })
keymap("x", "{", wrap_selection("{", "}"), { desc = "Wrap with {}", nowait = true })
keymap("x", '"', wrap_selection('"', '"'), { desc = 'Wrap with ""', nowait = true })
keymap("x", "'", wrap_selection("'", "'"), { desc = "Wrap with ''", nowait = true })
keymap("x", "`", wrap_selection("`", "`"), { desc = "Wrap with ``", nowait = true })

-- ===================================================================
-- JUMP TO BRACKET
-- ===================================================================
local function jump_to_bracket(target)
    return function()
        local start_pos = vim.api.nvim_win_get_cursor(0)
        local pattern = target == "open" and "[{(]" or "[})]"
        local flags = target == "open" and "bW" or "W"

        local search_pos = vim.fn.searchpos(pattern, flags .. 'n')

        if target == "open" then
            vim.cmd("silent! normal! [{")
            vim.cmd("silent! normal! [(")
        else
            vim.cmd("silent! normal! ]}")
            vim.cmdsilent! normal! ])")
        end
        local unmatched_pos = vim.api.nvim_win_get_cursor(0)

        if search_pos[1] ~= 0 then
            if unmatched_pos[1] == start_pos[1] and unmatched_pos[2] == start_pos[2] then
                vim.fn.cursor(search_pos[1], search_pos[2])
            else
                local dist_unmatched = math.abs(unmatched_pos[1] - start_pos[1])
                local dist_search = math.abs(search_pos[1] - start_pos[1])
                if dist_search < dist_unmatched then
                    vim.fn.cursor(search_pos[1], search_pos[2])
                end
            end
        end
    end
end

keymap({ "n", "x" }, "<leader>[", jump_to_bracket("open"), { desc = "Jump to opening bracket" })
keymap({ "n", "x" }, "<leader>]", jump_to_bracket("close"), { desc = "Jump to closing bracket" })
