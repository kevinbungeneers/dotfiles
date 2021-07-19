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
    ./home/sublimetext
  ];
  
  home.stateVersion = "21.05";
}