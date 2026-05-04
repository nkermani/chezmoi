{ config, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = config.home.sessionVariables.STUDENT_USERNAME;
        email = config.home.sessionVariables.STUDENT_EMAIL;
      };
      pull = {
        rebase = true;
      };
    };
  };
}
