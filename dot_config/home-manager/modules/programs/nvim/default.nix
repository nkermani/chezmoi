{ config, pkgs, lib, ... }:

let
  nvimConfigPath = /home/nkermani/.local/share/chezmoi/grenier/42-nvim-configs/nvim-nkermani;

  extraPlugins = let
    vp = pkgs.vimPlugins;
  in {
    plenary-nvim = { package = vp."plenary-nvim"; };
    nvim-web-devicons = { package = vp."nvim-web-devicons"; };
    nui-nvim = { package = vp."nui-nvim"; };
    gruvbox-material = { package = vp."gruvbox-material"; };
    lualine-nvim = { package = vp."lualine-nvim"; };
    bufferline-nvim = { package = vp."bufferline-nvim"; };
    neo-tree-nvim = { package = vp."neo-tree-nvim"; };
    edgy-nvim = { package = vp."edgy-nvim"; };
    telescope-nvim = { package = vp."telescope-nvim"; };
    trouble-nvim = { package = vp."trouble-nvim"; };
    nvim-cmp = { package = vp."nvim-cmp"; };
    cmp-nvim-lsp = { package = vp."cmp-nvim-lsp"; };
    cmp-buffer = { package = vp."cmp-buffer"; };
    cmp-path = { package = vp."cmp-path"; };
    luasnip = { package = vp."luasnip"; };
    cmp_luasnip = { package = vp."cmp_luasnip"; };
    lsp_signature-nvim = { package = vp."lsp_signature-nvim"; };
    nvim-treesitter = { package = vp."nvim-treesitter"; };
    nvim-autopairs = { package = vp."nvim-autopairs"; };
    conform-nvim = { package = vp."conform-nvim"; };
    gitsigns-nvim = { package = vp."gitsigns-nvim"; };
    comment-nvim = { package = vp."comment-nvim"; };
    vim-visual-multi = { package = vp."vim-visual-multi"; };
    vim-move = { package = vp."vim-move"; };
    toggleterm-nvim = { package = vp."toggleterm-nvim"; };
    fzf-lua = { package = vp."fzf-lua"; };
    snacks-nvim = { package = vp."snacks-nvim"; };
    nvim-spectre = { package = vp."nvim-spectre"; };
    oil-nvim = { package = vp."oil-nvim"; };
    dressing-nvim = { package = vp."dressing-nvim"; };
    nvim-scrollbar = { package = vp."nvim-scrollbar"; };
    nvim-window-picker = { package = vp."nvim-window-picker"; };
    precognition-nvim = { package = vp."precognition-nvim"; };
    noice-nvim = { package = vp."noice-nvim"; };
    yazi-nvim = { package = vp."yazi-nvim"; };
  };

  luaCore = builtins.readFile ./lua/core.lua;
  luaAutocmds = builtins.readFile ./lua/autocmds.lua;
  luaCommands = builtins.readFile ./lua/commands.lua;
  luaKeymaps = builtins.readFile ./lua/keymaps.lua;
  luaColorscheme = builtins.readFile ./lua/colorscheme.lua;
  luaPlugins =
    builtins.readFile ./lua/plugins/gitsigns.lua
    + builtins.readFile ./lua/plugins/treesitter.lua
    + builtins.readFile ./lua/plugins/lualine.lua
    + builtins.readFile ./lua/plugins/bufferline.lua
    + builtins.readFile ./lua/plugins/neo-tree.lua
    + builtins.readFile ./lua/plugins/telescope.lua
    + builtins.readFile ./lua/plugins/noice.lua
    + builtins.readFile ./lua/plugins/cmp.lua
    + builtins.readFile ./lua/plugins/snacks.lua
    + builtins.readFile ./lua/plugins/oil.lua
    + builtins.readFile ./lua/plugins/conform.lua
    + builtins.readFile ./lua/plugins/toggleterm.lua
    + builtins.readFile ./lua/plugins/dressing.lua
    + builtins.readFile ./lua/plugins/trouble.lua
    + builtins.readFile ./lua/plugins/edgy.lua
    + builtins.readFile ./lua/plugins/scrollbar.lua
    + builtins.readFile ./lua/plugins/spectre.lua
    + builtins.readFile ./lua/plugins/precognition.lua
    + builtins.readFile ./lua/plugins/autopairs.lua
    + builtins.readFile ./lua/plugins/devicons.lua
    + builtins.readFile ./lua/plugins/move.lua
    + builtins.readFile ./lua/plugins/yazi.lua;
  luaLsp = builtins.readFile ./lua/lsp.lua;
in
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

        options = { };

        theme.enable = false;

        treesitter = {
          enable = true;
          grammars = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [
            c lua python markdown rust
          ];
          addDefaultGrammars = false;
        };

        telescope.enable = true;

        lsp.lspconfig.enable = false;

        extraPlugins = extraPlugins;

        luaConfigPost =
          luaCore
          + luaAutocmds
          + luaCommands
          + luaKeymaps
          + luaColorscheme
          + luaPlugins
          + luaLsp;
      };
    };
  };

  home.packages = with pkgs; [
    lua-language-server
    rust-analyzer
    clang-tools
    python3Packages.python-lsp-server
    pyright
    typescript-language-server
    bash-language-server
    dot-language-server
  ];
}
