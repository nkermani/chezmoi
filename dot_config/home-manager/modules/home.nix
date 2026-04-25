{ config, pkgs, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = "/home/" + config.home.username;

  home.sessionVariables = {
    STUDENT_USERNAME = builtins.getEnv "STUDENT_USERNAME";
    STUDENT_EMAIL = builtins.getEnv "STUDENT_EMAIL";
    EDITOR="hx";
    VISUAL="hx";
    GIT_EDITOR="hx";
  };
  home.shellAliases = {
      g="git";
      ga="git add";
      gaa="git add --all";
      gc="git commit -v";
      gcmsg="git commit -m";
      gco="git checkout";
      gcb="git checkout -b";
      gd="git diff";
      gl="git pull";
      gp="git push";
      gst="git status";
      lg="lazygit";

  };

  home.stateVersion = "25.11";
}
