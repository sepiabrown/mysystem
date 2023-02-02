{ config, pkgs, ... }:

let
  extraConfig = {
    core = {
      editor = "nvim";
      pager  = "diff-so-fancy | less --tabs=4 -RFX";
    };
    merge.tool = "vimdiff";
    mergetool = {
      cmd    = "nvim -f -c \"Gvdiffsplit!\" \"$MERGED\"";
      prompt = false;
    };
    pull.rebase = false;
    init.defaultBranch = "master";
    lfs.enable = true;
    feature.manyFiles = true;
    # url."https://github.com/".insteadOf = "git://github.com/";
  };
in
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = config.userInfo.name;
    userEmail = config.userInfo.email;
    aliases = {
      amend = "commit --amend -m";
      pushall = "!git remote | xargs -L1 git push --all";
      graph = "log --decorate --oneline --graph";
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
    };
    inherit extraConfig;
    ignores = [
      ".DS_Store"
      "result"
      ".direnv"
    ];
    # signing = {
    #   key = "6A9DC1FC403B1F49";
    #   signByDefault = false;
    # };
  };
}
