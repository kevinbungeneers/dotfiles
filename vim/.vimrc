set laststatus=2
set noshowmode
set ttimeoutlen=50
set number

colorscheme nord
syntax on

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

map <C-o> :NERDTreeToggle<CR>
