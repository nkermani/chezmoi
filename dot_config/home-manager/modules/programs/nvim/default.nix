{ config, pkgs, lib, ... }:

{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = false;

        lsp = {
          enable = true;
          formatOnSave = true;
          mappings = {
            goToDefinition = "gd";
          };
        };

        maps = {
          normal = {
            "<C-]>" = {
              action = "<cmd>lua vim.lsp.buf.definition()<CR>";
              desc = "LSP go to definition";
              silent = true;
            };
          };
        };

        languages = {
          clang = { enable = true; };      # C/C++
          csharp = { enable = true; };     # C#
          python = { enable = true; };     # Python
          rust = { enable = true; };       # Rust
          typescript = { enable = true; }; # TypeScript/JavaScript
          go = { enable = true; };         # Go
          nix = { enable = true; };        # Nix
          zig = { enable = true; };        # Zig
          php = { enable = true; };        # PHP
        };

        mini = {
          basics = { enable = true; };    # sensible defaults
          ai = { enable = true; };         # improved text objects
          align = { enable = true; };      # text alignment
          animate = { enable = true; };    # smooth animations
          bracketed = { enable = true; };  # bracket navigation
          bufremove = { enable = true; };  # close buffers without wrecking layout
          clue = { enable = true; };       # keymap hints
          comment = { enable = true; };    # comment with gc
          completion = { enable = true; }; # autocompletion
          cursorword = { enable = true; }; # underline word under cursor
          diff = { enable = true; };       # git diff signs
          files = { enable = true; };      # file explorer
          fuzzy = { enable = true; };      # fuzzy matching
          git = { enable = true; };        # git integration
          hipatterns = { enable = true; }; # highlight patterns
          icons = { enable = true; };      # filetype icons
          indentscope = { enable = true; }; # indent guides
          jump = { enable = true; };       # jump motions
          jump2d = { enable = true; };     # 2D cursor jumping
          misc = { enable = true; };       # miscellaneous utilities
          move = { enable = true; };       # move lines/selection
          notify = { enable = true; };     # notification system
          operators = { enable = true; };  # text operators
          pairs = { enable = true; };      # auto-pair brackets
          pick = { enable = true; };       # fuzzy picker
          sessions = { enable = true; };   # session management
          snippets = { enable = true; };   # code snippets
          splitjoin = { enable = true; };  # split/join expressions
          starter = { enable = false; };   # start screen (disabled - content nil error)
          statusline = { enable = true; }; # status line
          surround = { enable = true; };   # surround text objects
          tabline = { enable = true; };    # tabline
          test = { enable = true; };       # test integration
          trailspace = { enable = true; }; # trailing whitespace
          visits = { enable = true; };     # track recent locations
        };
      };
    };
  };
}
