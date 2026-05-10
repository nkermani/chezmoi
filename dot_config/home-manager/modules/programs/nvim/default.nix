{ config, pkgs, lib, ... }:

{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = false;

        # LSP / language support handled by LazyVim distro
        # (installed via lazyvim-nix module)

        lsp = {
          enable = false;
        };

        languages = {
          clang = { enable = false; };
          csharp = { enable = false; };
          python = { enable = false; };
          rust = { enable = false; };
          typescript = { enable = false; };
          go = { enable = false; };
          nix = { enable = false; };
          zig = { enable = false; };
          php = { enable = false; };
        };

        mini = {
          basics = { enable = false; };
          ai = { enable = false; };
          align = { enable = false; };
          animate = { enable = false; };
          bracketed = { enable = false; };
          bufremove = { enable = false; };
          clue = { enable = false; };
          comment = { enable = false; };
          completion = { enable = false; };
          cursorword = { enable = false; };
          diff = { enable = false; };
          files = { enable = false; };
          fuzzy = { enable = false; };
          git = { enable = false; };
          hipatterns = { enable = false; };
          icons = { enable = false; };
          indentscope = { enable = false; };
          jump = { enable = false; };
          jump2d = { enable = false; };
          misc = { enable = false; };
          move = { enable = false; };
          notify = { enable = false; };
          operators = { enable = false; };
          pairs = { enable = false; };
          pick = { enable = false; };
          sessions = { enable = false; };
          snippets = { enable = false; };
          splitjoin = { enable = false; };
          starter = { enable = false; };
          statusline = { enable = false; };
          surround = { enable = false; };
          tabline = { enable = false; };
          test = { enable = false; };
          trailspace = { enable = false; };
          visits = { enable = false; };
        };
      };
    };
  };
}
