{ pkgs }:

{
  enable = true;
  plugins = [
    pkgs.vimPlugins.nord-vim
    pkgs.vimPlugins.nerdtree
    pkgs.vimPlugins.lightline-vim
  ];
  extraConfig = builtins.readFile ./extraConfig;
}
