{
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox-material";
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
        };
        soft-wrap = {
          enable = true;
        };
        statusline = {
          left = [ "mode" "spinner" "version-control" ];
          right = [ "file-name" "file-encoding" "separator" "file-type" "file-line-ending" "position" ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
      keys = {
        normal = {
          "C-s" = ":w";
          "C-q" = ":q";
          A-y = [":new" ":insert-output yazi --chooser-file=/dev/stdout" ":buffer-close!" ":redraw"];
        };
      };
    };
  };
}
