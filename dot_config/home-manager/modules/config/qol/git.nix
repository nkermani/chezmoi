{ config, ... }:

{
  programs.git = {
    signing.format = null;
    settings = {
      core = {
        editor = "code";
      };
      user = {
        name = config.home.sessionVariables.STUDENT_USERNAME;
        email = config.home.sessionVariables.NKERMANI_EMAIL;
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        ff = "only";
      };
      push = {
        default = "simple";
      };
      merge = {
        conflictstyle = "diff3";
      };
      help = {
        autocorrect = 50;
      };
      alias = {
        co = "checkout";
        st = "status";
        sw = "show";
        sws = "sw --stat";
        swn = "show -- . ':!*.pb.go'";
        swns = "show --stat -- . ':!*.pb.go'";
        unstage = "reset HEAD --";
        ls = ''log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --date=relative'';
        df = "diff";
        dc = "diff --cached";
        cm = "!git add -A && git commit -m";
        amend = "!git add -A && git commit --amend --no-edit";
        rbm = "!git fetch origin master-passing-tests && git rebase origin/master-passing-tests";
        rb = ''!f() { git rebase -i "$1"~; }; f'';
        rbc = "!git add -A && git rebase --continue";
        rba = "rebase --abort";
        cp = "cherry-pick";
        cpa = "cherry-pick --abort";
        cpc = "!git add -A && git cherry-pick --continue";
        pusho = ''!git push -u origin $(git rev-parse --abbrev-ref HEAD)'';
        pushf = "push --force";
        recent = "branch --sort=-committerdate";
      };
    };
  };
}
