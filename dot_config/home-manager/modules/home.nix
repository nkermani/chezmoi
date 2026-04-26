{ config, pkgs, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.sessionVariables = {
    STUDENT_USERNAME = builtins.getEnv "STUDENT_USERNAME";
    STUDENT_EMAIL = builtins.getEnv "STUDENT_EMAIL";
    EDITOR="code";
    VISUAL="code";
    GIT_EDITOR="code";
  };

  home.stateVersion = "25.11";
}
