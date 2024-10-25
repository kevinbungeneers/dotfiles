{ config, pkgs, ... }:

{
  home.username = "kevin";
  home.homeDirectory = "/Users/kevin";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.git-lfs
    pkgs.ripgrep
    pkgs.fd
  ];

  imports = [
    ./zsh
    ./direnv
    ./lsd
    ./git
    ./gpg
    ./bat
    ./fzf
    ./htop
    ./jq
    ./tmux
    ./vim
    ./sublimetext
  ];

  programs.home-manager.enable = true;
}
