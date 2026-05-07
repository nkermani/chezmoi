{ config, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "1337";
      # style = "numbers,changes,header";
      # paging = "never";
    };
  };
}
