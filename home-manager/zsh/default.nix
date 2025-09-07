{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    initContent = builtins.readFile ./initContent;
    profileExtra = builtins.readFile ./profileExtra;
  };
}