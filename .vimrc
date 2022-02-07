let g:ale_fixers=['tsserver']
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_enter=0
let g:ale_lint_on_filetype_changed=0

set directory^=$HOME/.vim/swap//
set backupcopy=yes
set cmdheight=2
set relativenumber
set updatetime=50
set hidden
set nowrap
set number
set omnifunc=ale#completion#OmniFunc
set showtabline=2
set undodir=~/.vim/undo
set undofile
set background=dark
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
filetype indent on
colorscheme gruvbox

nnoremap <C-P>aa :argadd %<CR>
nnoremap <C-P>ad :argdelete %<CR>
nnoremap <C-P>f :find ./src/**/*
nnoremap <C-P>g :grep -r  ./src/**<Left><Left><Left><Left><Left><Left><Left><Left><Left>

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

autocmd BufNewFile  *.tsx 0r ~/snippets/reactComponent.tsx
autocmd FileType typescript*
  \ setlocal formatprg=npx\ prettier\ --parser\ typescript |
  \ setlocal formatexpr= |
  \ setlocal omnifunc=ale#completion#OmniFunc

call plug#begin('~/.vim/plugged')
  Plug 'takac/vim-hardtime'
  Plug 'dense-analysis/ale'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-flagship'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-apathy'
  Plug 'tpope/vim-obsession'
call plug#end()
