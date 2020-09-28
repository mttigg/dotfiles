let mapleader = "\<Space>"
let g:airline_powerline_fonts = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint:one --'
let g:netrw_banner = 0
" let g:netrw_altv=1

nnoremap <leader>rv :source $MYVIMRC<CR>
" handy git commands
nnoremap <leader>gs :!clear && git status<CR>
nnoremap <leader>gd :!clear && git diff<CR>
nnoremap <leader>gl :!clear && git log<CR>
nnoremap <leader>gc :!clear && git commit<CR>
nnoremap <leader>gq :GitGutterQuickFix :cn<CR>
nnoremap <leader>tfi :!clear && npm run ci-feature -- %<CR>
nnoremap <leader>tfb :!clear && npm run feature -- %<CR>
nnoremap <leader>tfa :!clear && npm run feature<CR>
nnoremap <leader>tu :!clear && jest %<CR>
nnoremap <leader>c :!find . -type f -name '*.swp' -delete<CR>
nnoremap <leader>i :SortImport<CR>

" exit insert mode by pressing jj 
" inoremap jj <Esc>

syntax on
colorscheme molokai
set shiftwidth=2
set number
set ignorecase
set smartcase
set nowrap
set encoding=UTF-8
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set updatetime=100

call plug#begin('~/.vim/plugged')
 
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'vim-airline/vim-airline'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'ruanyl/vim-sort-imports'

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

call plug#end()
