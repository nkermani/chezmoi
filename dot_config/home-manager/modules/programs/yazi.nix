{ pkgs, config, lib, ... }:

let
  yaziConfig = config.xdg.configHome or "${config.home.homeDirectory}/.config";
in

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    theme = {
      manager = {
        cwd = { fg = "#7daea3"; bold = true; };
        copied = { fg = "#7daea3"; };
        cut = { fg = "#ea6962"; };
        link = { fg = "#89b482"; };
        hovered = { bg = "#3c3836"; };
        preview_hovered = { bg = "#32302f"; };
        selected = { fg = "#d3869b"; bg = "#3c3836"; };
        find_keyword = { fg = "#ea6962"; italic = true; };
        find_position = { fg = "#d8a657"; bg = "#504945"; };
        marker_selected = { fg = "#d3869b"; };
        marker_copied = { fg = "#7daea3"; };
        marker_cut = { fg = "#ea6962"; };
        border_style = { fg = "#504945"; };
        border_symbol = "│";
        title = { fg = "#a89984"; };
      };
      status = {
        separator_open = "";
        separator_close = "";
        separator_style = { fg = "#504945"; };
        mode_normal = { fg = "#282828"; bg = "#a89984"; bold = true; };
        mode_select = { fg = "#282828"; bg = "#d3869b"; bold = true; };
        mode_unset = { fg = "#282828"; bg = "#ea6962"; bold = true; };
        progress_label = { fg = "#d4be98"; bold = true; };
        progress_normal = { fg = "#7daea3"; bg = "#3c3836"; };
        permissions_t = { fg = "#a9b665"; };
        permissions_s = { fg = "#ea6962"; };
        permissions_r = { fg = "#d8a657"; };
        permissions_w = { fg = "#ea6962"; };
        permissions_x = { fg = "#7daea3"; };
        permissions_u = { fg = "#d8a657"; };
      };
      input = {
        border = { fg = "#504945"; };
        title = { fg = "#a89984"; };
        value = { fg = "#d4be98"; };
        selected = { fg = "#282828"; bg = "#7daea3"; };
      };
      select = {
        border = { fg = "#504945"; };
        active = { fg = "#d3869b"; };
        inactive = { fg = "#a89984"; };
      };
      tasks = {
        border = { fg = "#504945"; };
        title = { fg = "#a89984"; };
        hovered = { bg = "#3c3836"; };
      };
      which = {
        mask = { bg = "#282828"; };
        cand = { fg = "#d4be98"; };
        rest = { fg = "#a89984"; };
        desc = { fg = "#7daea3"; };
        separator = "  ";
        separator_style = { fg = "#504945"; };
      };
      help = {
        on = { fg = "#7daea3"; };
        run = { fg = "#d3869b"; };
        desc = { fg = "#d4be98"; };
        hovered = { fg = "#d4be98"; bg = "#3c3836"; };
        footer = { fg = "#a89984"; bg = "#282828"; };
        sep = { fg = "#504945"; };
      };
      notify = {
        title_info = { fg = "#282828"; bg = "#7daea3"; };
        title_warn = { fg = "#282828"; bg = "#d8a657"; };
        title_error = { fg = "#282828"; bg = "#ea6962"; };
      };
      pick = {
        border = { fg = "#504945"; };
        active = { fg = "#d3869b"; };
        inactive = { fg = "#a89984"; };
      };
      tab = {
        active = { fg = "#d3869b"; };
        inactive = { fg = "#a89984"; bg = "#32302f"; };
        width = 1;
      };
    };
  };

  programs.yazi.settings = {
    manager = {
      ratio = [ 1 2 5 ];
    };
    plugin = {
      prepend_previewers = [
        { url = "*.csv"; run = "duckdb"; }
        { url = "*.tsv"; run = "duckdb"; }
        { url = "*.json"; run = "duckdb"; }
        { url = "*.parquet"; run = "duckdb"; }
        { url = "*.txt"; run = "duckdb"; }
        { url = "*.xlsx"; run = "duckdb"; }
        { url = "*.db"; run = "duckdb"; }
        { url = "*.duckdb"; run = "duckdb"; }
      ];
      prepend_preloaders = [
        { url = "*.csv"; run = "duckdb"; multi = false; }
        { url = "*.tsv"; run = "duckdb"; multi = false; }
        { url = "*.json"; run = "duckdb"; multi = false; }
        { url = "*.parquet"; run = "duckdb"; multi = false; }
        { url = "*.txt"; run = "duckdb"; multi = false; }
        { url = "*.xlsx"; run = "duckdb"; multi = false; }
      ];
    };
  };

  programs.yazi.keymap = {
    manager = {
      prepend_keymaps = [
        {
          on = "H";
          run = "plugin duckdb -1";
          desc = "Scroll one column to the left";
        }
        {
          on = "L";
          run = "plugin duckdb +1";
          desc = "Scroll one column to the right";
        }
        {
          on = [ "g" "o" ];
          run = "plugin duckdb -open";
          desc = "Open with duckdb";
        }
        {
          on = [ "g" "u" ];
          run = "plugin duckdb -ui";
          desc = "Open with duckdb ui";
        }
      ];
    };
  };

  xdg.configFile."yazi/init.lua".text = ''
    -- DuckDB plugin configuration
    require("duckdb"):setup({
      mode = "standard",
      row_id = false,
      minmax_column_width = 21,
    })
  '';

  # Create a shell activation script that patches the duckdb plugin
  home.activation.patchDuckdbPlugin = lib.hm.dag.entryAfter ["linkGeneration"] ''
    # Patch the duckdb plugin main.lua to enable highlighting
    DUCKDB_MAIN="''${HOME}/.config/yazi/plugins/duckdb.yazi/main.lua"
    if [ -f "$DUCKDB_MAIN" ]; then
      if grep -q '".highlight_results off"' "$DUCKDB_MAIN"; then
        sed -i 's/".highlight_results off"/".highlight_results on"/g' "$DUCKDB_MAIN"
        $VERBOSE_ECHO "Patched duckdb plugin to enable highlighting"
      fi
    fi
  '';

  home.file."${config.home.homeDirectory}/.duckdbrc".text = ''
    SET lambda_syntax='ENABLE_SINGLE_ARROW';
    .highlight_colors column_name magenta bold
    .highlight_colors column_type gray
    .highlight_colors string_value cyan
    .highlight_colors numeric_value green
    .highlight_colors temporal_value blue
    .highlight_colors null_value gray
    .highlight_colors footer gray
  '';
}