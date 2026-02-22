local plugins = {
  {
    "nvim-lua/plenary.nvim",
    cmd = "Plenary",
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-buffer",
    after = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-path",
    after = "nvim-cmp",
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
}

return plugins
