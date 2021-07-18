{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "kevin";
  home.homeDirectory = "/Users/kevin";

  home.packages = [
    pkgs.diff-so-fancy
    pkgs.git-lfs
    pkgs.httpie
    pkgs.mkcert
    pkgs.nss
    pkgs.ripgrep
  ];

  # home.file."Library/Application Support/Sublime Text/Packages/User/Preferences.sublime-settings".source = ./home/sublimetext/Preferences.sublime-settings;
  # home.file.".config/karabiner/karabiner.json".source = ./home/karabiner/karabiner.json;

  imports = [
    ./home/zsh
    ./home/git
    ./home/gpg
    ./home/bat
    ./home/fzf
    ./home/htop
    ./home/jq
    ./home/tmux
    ./home/vim
  ];
  
  home.stateVersion = "21.05";
}
