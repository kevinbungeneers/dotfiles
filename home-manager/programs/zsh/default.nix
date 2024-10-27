{ pkgs }:

{
  enable = true;

  autocd = true;
  enableCompletion = true;
  syntaxHighlighting.enable = true;
  autosuggestion.enable = true;

  plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
    {
      name = "powerlevel10k-config";
      src = ./p10k-config;
      file = "p10k.zsh";
    }
    {
      name = "zsh-history-substring-search";
      src  = pkgs.zsh-history-substring-search;
      file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
    }
  ];

  initExtraFirst = builtins.readFile ./initExtraFirst;
  initExtra = builtins.readFile ./initExtra;
  profileExtra = builtins.readFile ./profileExtra;

  sessionVariables = {
    ZSH_HIGHLIGHT_HIGHLIGHTERS = ["main" "brackets" "pattern" "line" "cursor" "root"];
  };

  shellAliases = {
    cat = "bat --paging=never";
    doco = "docker compose";
    dexec = "docker compose exec";
  };

  history = {
    extended = true;
    share = true;
    expireDuplicatesFirst = true;
    ignoreDups = true;
  };
}