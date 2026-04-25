{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
  };

  programs.nodejs = {
    enable = true;
    package = pkgs.nodejs_22;
  };
}