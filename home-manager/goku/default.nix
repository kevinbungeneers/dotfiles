{ config, pkgs, ... }:

let
  ednConfigFile = "$HOME/.dotfiles/karabiner/karabiner.edn";
in
{
  home.packages = [ pkgs.goku ];

  programs.zsh.initContent = "export GOKU_EDN_CONFIG_FILE=${ednConfigFile}";
  programs.fish.shellInit = "set -x GOKU_EDN_CONFIG_FILE ${ednConfigFile}";
}
