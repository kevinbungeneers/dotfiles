{ config, pkgs, ... }:

{
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Kevin Bungeneers";
    userEmail = "git@bungerous.be";
    aliases = {
      co = "checkout";
      st = "status";
      t = "tag -n";
      l = "log --graph --date=short";
      changes = "log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\" --name-status";
      short = "log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\"";
      changelog = "log --pretty=format:\" * %s\"";
      shortnocolor = "log --pretty=format:\"%h %cr %cn %s\"";
    };
    signing = {
      key = "5195040C8E0B6245!";
      signByDefault = true;
    };
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers decorations";
        syntax-theme = "Nord";
        whitespace-error-style = "22 reverse";
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-style = "bold yellow ul";
          file-decoration-style = "none";
        };
      };
    };
    extraConfig = {
      core = {
        editor = "vim";
      };

      pager = {
        diff = "delta";
        log = "delta";
        reflog = "delta";
        show = "delta";
      };

      init = {
        defaultBranch = "main";
      };

      tag = {
        forceSignAnnotated = true;
      };

      color = {
        ui = "true";
        diff = {
          meta = "yellow bold";
          frag = "magenta bold";
          old = "red";
          new = "green";
        };
        diff = {
          current = "yellow reverse";
          local = "yellow";
          remote = "green";
        };
      };

      push = {
        default = "tracking";
      };

      pull = {
        rebase = false;
      };

      filter = {
        lfs = {
          required = true;
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
        };
      };
    };
    ignores = [
      # Compiled source #
      "*.com"
      "*.class"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"

      # Packages #
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"

      # Logs and databases #
      "*.log"
      # "*.sql"
      "*.sqlite"

      # OS generated files #
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"

      # IDE and tool related files #
      ".idea/"
      ".vagrant/"
      ".vscode/"
    ];
  };
}