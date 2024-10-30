{ pkgs, lib, config, options, specialArgs, modulesPath }:

{
  home.username = "kevin";
  home.homeDirectory = "/Users/kevin";
  home.stateVersion = "24.05";

  home.file = {
    "Library/Application Support/Sublime Text/Packages/home-manager/Preferences.sublime-settings".source = ./files/sublime-text/Preferences.sublime-settings;
    ".config/fish/fish_variables".source = ./files/fish/fish_variables;
  };

  programs = {
    bat     = import ./programs/bat;
    direnv  = import ./programs/direnv;
    fd      = import ./programs/fd;
    fish    = import ./programs/fish;
    fzf     = import ./programs/fzf;
    gh      = import ./programs/gh;
    git     = import ./programs/git;
    gpg     = import ./programs/gpg;
    htop    = import ./programs/htop;
    jq      = import ./programs/jq;
    lsd     = import ./programs/lsd;
    ripgrep = import ./programs/ripgrep;
    tmux    = import ./programs/tmux;
    vim     = import ./programs/vim { inherit pkgs; };
  };
}