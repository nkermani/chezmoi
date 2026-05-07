-- ====== AUTOCOMMANDS ======

vim.api.nvim_create_autocmd("ModeChanged", {
  group = vim.api.nvim_create_augroup("VisualCopy", { clear = true }),
  pattern = { "[vV\\x16]:n", "[vV\\x16]:i" },
  callback = function()
    if vim.v.operator ~= "d" and vim.v.operator ~= "c" and vim.bo.modifiable then
      local save_cursor = vim.fn.getpos(".")
      vim.cmd('silent! normal! gvy')
      vim.fn.setpos(".", save_cursor)
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

local function clean_on_save()
  if not vim.bo.modifiable or vim.bo.filetype == "python" then return end
  local save_cursor = vim.fn.getpos(".")
  vim.cmd([[%s/\\s\\+$//e]])
  vim.cmd([[%s/\\n\\{3,}/\\r\\r/e]])
  local last_line = vim.api.nvim_buf_line_count(0)
  local last_content = vim.api.nvim_buf_get_lines(0, last_line - 1, last_line, false)[1]
  if last_content ~= "" then
    vim.api.nvim_buf_set_lines(0, last_line, last_line, false, { "" })
  end
  vim.fn.setpos(".", save_cursor)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = clean_on_save,
})

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" and vim.bo.modifiable and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! update")
    end
  end,
})

if vim.fn.has("wsl") == 1 then
  vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
    group = vim.api.nvim_create_augroup("AlacrittyCursor", { clear = true }),
    callback = function()
      vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
    end,
  })
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  callback = function()
    vim.schedule(function()
      if vim.api.nvim_win_is_valid(0) and vim.bo.buftype == "" then
        vim.wo.winbar = "%=%#WinBar#%@v:lua.smart_close@ 󰅖 %*"
      end
    end)
  end,
})


-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     local ft = vim.bo.filetype
--     local skip = { "oil", "dashboard", "telescope", "Trouble", "qf", "neo-tree", "alpha" }
--     for _, s in ipairs(skip) do if ft == s then return end end
--     if vim.bo.buftype ~= "" or vim.api.nvim_win_get_config(0).relative ~= "" or vim.fn.isdirectory(vim.fn.expand("%:p")) ~= 0 then return end
--     local ok, nt_command = pcall(require, "neo-tree.command")
--     if ok then
--       local manager = require("neo-tree.sources.manager")
--       local state = manager.get_state("filesystem")
--       if not state.winid or not vim.api.nvim_win_is_valid(state.winid) then
--         vim.schedule(function()
--           if not state.winid or not vim.api.nvim_win_is_valid(state.winid) then
--             pcall(nt_command.execute, { action = "show", source = "filesystem", position = "left" })
--           end
--         end)
--       end
--     end
--   end,
-- })


vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.keymap.set("x", "[", wrap_selection("[", "]"), { buffer = true, nowait = true, desc = "Wrap with []" })
  end,
})

