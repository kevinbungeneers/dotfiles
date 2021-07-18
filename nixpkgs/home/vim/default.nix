{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.dracula-vim
      pkgs.vimPlugins.nerdtree
      pkgs.vimPlugins.lightline-vim
    ];
    extraConfig = ''
      set laststatus=2
      set noshowmode
      set ttimeoutlen=50
      set number

      syntax enable
      packadd! dracula-vim | colorscheme dracula

      let g:lightline = {
            \ 'colorscheme': 'dracula',
            \ }

      map <C-o> :NERDTreeToggle<CR>
    '';
  };
}