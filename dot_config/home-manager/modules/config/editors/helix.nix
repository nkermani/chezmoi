{
  programs.helix = {
    settings = {
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
            normal = "N";
            insert = "I";
            select = "V";
          };
        };
        lsp = {
          display-messages = false;
          display-inlay-hints = false;
        };
      };
    };
  };
}
