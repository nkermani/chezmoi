local obsidian = require("obsidian")

obsidian.setup({
  workspaces = {
    {
      name = "notes",
      path = "~/.nkermani/notes",
    },
  },
  mappings = {
    ["gh"] = {
      action = "goto_url",
      opts = { callback = vim.ui.open, desc = "Open URL" },
    },
  },
  completion = {
    nvim_cmp = true,
  },
  attachments = {
    img_folder = "assets/images",
    img_text_func = function(path)
      local rel_path = string.match(path, "assets/images/(.+)")
      return string.format("![%s](%s)", rel_path, path)
    end,
  },
  daily_notes = {
    folder = "daily",
  },
  templates = {
    folder = "templates",
  },
  ui = {
    enable = true,
  },
})
