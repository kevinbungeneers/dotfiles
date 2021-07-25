{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;

    enableCompletion = true;
    enableAutosuggestions = true;

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src  = pkgs.fetchFromGitHub {
          owner  = "zsh-users";
          repo   = "zsh-syntax-highlighting";
          rev    = "0.7.1";
          sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
        };
      }
      {
        name = "pure";
        src  = pkgs.fetchFromGitHub {
          owner  = "sindresorhus";
          repo   = "pure";
          rev    = "v1.16.0";
          sha256 = "1wsmv32pdcs0y5xq4537v66bijgnblj04bqa2k2pwja0nja3hyby";
        };
      }
      {
        name = "zsh-history-substring-search";
        src  = pkgs.fetchFromGitHub {
          owner  = "zsh-users";
          repo   = "zsh-history-substring-search";
          rev    = "v1.0.2";
          sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
        };
      }
    ];

    initExtra = builtins.readFile ./initExtra;
    profileExtra = builtins.readFile ./profileExtra;

    sessionVariables = {
      LSCOLORS = "exfxcxdxbxGxDxabagacad";
      LS_COLORS = "di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:";
      ZSH_HIGHLIGHT_HIGHLIGHTERS = ["main" "brackets" "pattern" "line" "cursor" "root"];
    };

    shellAliases = {
      cat = "bat --paging=never";
    };

    history = {
      extended = true;
      share = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
    };
  };
}