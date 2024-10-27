{
  enable = true;

  userName = "Kevin Bungeneers";
  userEmail = "git@bungerous.be";

  aliases = {
    cof = "!checkout_fzf() { git branch --format=\"%(refname:short)\" | fzf | xargs git checkout; }; checkout_fzf";
    aaf = "!add_fzf() { git status -s | awk '{if ($1 ~ /R/) print $4; else print $2}' | fzf -m | xargs git add; }; add_fzf";
    co = "checkout";
    st = "status";
    t = "tag -n";
    l = "log --graph --date=short";
    changes = "log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\" --name-status";
    short = "log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\"";
    changelog = "log --pretty=format:\" * %s\"";
    shortnocolor = "log --pretty=format:\"%h %cr %cn %s\"";
    cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
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
      autoSetupRemote = true;
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

  lfs.enable = false;

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
}