let g:ale_completion_autoimport = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
let g:ale_floating_preview = 1
let g:flagship_skip = 'Fugitive\|Sleuth'
let g:tabprefix = "\ %{fugitive#head(5)}\ %{flagship#user()}\ \ "
let g:tablabel= "\ %N\ "

set cmdheight=2
set hidden
set nowrap
set number
set omnifunc=ale#completion#OmniFunc
set path+=src/**
set showtabline=2
set statusline=\ %t\ #%n\ -\ %L
set undodir=~/.vim/undo
set undofile
set background=dark

colorscheme gruvbox

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

autocmd BufNewFile  *.tsx 0r ~/snippets/reactComponent.tsx
autocmd FileType typescript setlocal formatprg=npx\ prettier\ --parser\ typescript
autocmd FileType typescriptreact setlocal formatprg=npx\ prettier\ --parser\ typescript

call plug#begin('~/.vim/plugged')
  Plug 'dense-analysis/ale'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-flagship'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
call plug#end()

