{ config, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "GruvboxMaterialDark";
      # style = "numbers,changes,header";
      # paging = "never";
    };
  };

  home.file = {
    ".config/bat/themes/GruvboxMaterialDark.tmTheme".source = ../../bat/themes/GruvboxMaterialDark.tmTheme;
  };
}
