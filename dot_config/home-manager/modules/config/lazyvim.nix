{ config, lib, ... }:

{
  # Remove old NvChad config files that would interfere with LazyVim
  home.activation.removeOldNvimConfig = lib.mkAfter ''
    if [ -d "$HOME/.config/nvim/lua/configs" ]; then
      rm -f "$HOME/.config/nvim/lua/configs/conform.lua"
      rm -f "$HOME/.config/nvim/lua/configs/lazy.lua"
      rm -f "$HOME/.config/nvim/lua/configs/lspconfig.lua"
      rmdir "$HOME/.config/nvim/lua/configs" 2>/dev/null || true
    fi
    rm -f "$HOME/.config/nvim/lua/plugins/init.lua"
    rm -f "$HOME/.config/nvim/lua/autocmds.lua"
    rm -f "$HOME/.config/nvim/lua/chadrc.lua"
    rm -f "$HOME/.config/nvim/lua/mappings.lua"
    rm -f "$HOME/.config/nvim/lua/options.lua"
  '';

  xdg.configFile = {
    "nvim/init.lua".text = ''
      require("config.lazy")
    '';

    "nvim/lua/config/lazy.lua".text = ''
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
          vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
          }, true, {})
          vim.fn.getchar()
          os.exit(1)
        end
      end
      vim.opt.rtp:prepend(lazypath)

      require("lazy").setup({
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          { import = "plugins" },
        },
        defaults = {
          lazy = false,
          version = false,
        },
        install = { colorscheme = { "tokyonight", "habamax" } },
        checker = { enabled = true, notify = false },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })
    '';

    "nvim/lua/config/options.lua".text = ''
      -- Options are automatically loaded before lazy.nvim startup
      -- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
      -- Add any additional options here
    '';

    "nvim/lua/config/keymaps.lua".text = ''
      -- Keymaps are automatically loaded on the VeryLazy event
      -- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
      -- Add any additional keymaps here
    '';

    "nvim/lua/config/autocmds.lua".text = ''
      -- Autocmds are automatically loaded on the VeryLazy event
      -- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
      -- Add any additional autocmds here
    '';

    "nvim/lua/plugins/example.lua".text = ''
      -- since this is just an example spec, don't actually load anything here and return an empty spec
      -- stylua: ignore
      if true then return {} end

      -- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
      --
      -- In your plugin files, you can:
      -- * add extra plugins
      -- * disable/enabled LazyVim plugins
      -- * override the configuration of LazyVim plugins
      return {
        -- add gruvbox
        { "ellisonleao/gruvbox.nvim" },

        -- Configure LazyVim to load gruvbox
        {
          "LazyVim/LazyVim",
          opts = {
            colorscheme = "gruvbox",
          },
        },

        -- change trouble config
        {
          "folke/trouble.nvim",
          opts = { use_diagnostic_signs = true },
        },

        -- disable trouble
        { "folke/trouble.nvim", enabled = false },

        -- override nvim-cmp and add cmp-emoji
        {
          "hrsh7th/nvim-cmp",
          dependencies = { "hrsh7th/cmp-emoji" },
          ---@param opts cmp.ConfigSchema
          opts = function(_, opts)
            table.insert(opts.sources, { name = "emoji" })
          end,
        },

        -- change some telescope options and a keymap to browse plugin files
        {
          "nvim-telescope/telescope.nvim",
          keys = {
            -- add a keymap to browse plugin files
            -- stylua: ignore
            {
              "<leader>fp",
              function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
              desc = "Find Plugin File",
            },
          },
          -- change some options
          opts = {
            defaults = {
              layout_strategy = "horizontal",
              layout_config = { prompt_position = "top" },
              sorting_strategy = "ascending",
              winblend = 0,
            },
          },
        },

        -- add pyright to lspconfig
        {
          "neovim/nvim-lspconfig",
          ---@class PluginLspOpts
          opts = {
            ---@type lspconfig.options
            servers = {
              pyright = {},
            },
          },
        },

        -- add tsserver and setup with typescript.nvim instead of lspconfig
        {
          "neovim/nvim-lspconfig",
          dependencies = {
            "jose-elias-alvarez/typescript.nvim",
            init = function()
              require("lazyvim.util").lsp.on_attach(function(_, buffer)
                -- stylua: ignore
                vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
                vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
              end)
            end,
          },
          ---@class PluginLspOpts
          opts = {
            ---@type lspconfig.options
            servers = {
              tsserver = {},
            },
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
              tsserver = function(_, opts)
                require("typescript").setup({ server = opts })
                return true
              end,
            },
          },
        },

        -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
        -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
        { import = "lazyvim.plugins.extras.lang.typescript" },

        -- add more treesitter parsers
        {
          "nvim-treesitter/nvim-treesitter",
          opts = {
            ensure_installed = {
              "bash",
              "html",
              "javascript",
              "json",
              "lua",
              "markdown",
              "markdown_inline",
              "python",
              "query",
              "regex",
              "tsx",
              "typescript",
              "vim",
              "yaml",
            },
          },
        },

        -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
        -- would overwrite `ensure_installed` with the new value.
        -- If you'd rather extend the default config, use the code below instead:
        {
          "nvim-treesitter/nvim-treesitter",
          opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
              "tsx",
              "typescript",
            })
          end,
        },

        -- the opts function can also be used to change the default opts:
        {
          "nvim-lualine/lualine.nvim",
          event = "VeryLazy",
            opts = function(_, opts)
              table.insert(opts.sections.lualine_x, {
                function()
                  return ":-)"
                end,
              })
            end,
        },

        -- or you can return new options to override all the defaults
        {
          "nvim-lualine/lualine.nvim",
          event = "VeryLazy",
          opts = function()
            return {
              --[[add your custom lualine config here]]
            }
          end,
        },

        -- use mini.starter instead of alpha
        { import = "lazyvim.plugins.extras.ui.mini-starter" },

        -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
        { import = "lazyvim.plugins.extras.lang.json" },

        -- add any tools you want to have installed below
        {
          "williamboman/mason.nvim",
          opts = {
            ensure_installed = {
              "stylua",
              "shellcheck",
              "shfmt",
              "flake8",
            },
          },
        },
      }
    '';
  };
}
