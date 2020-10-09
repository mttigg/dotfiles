let g:airline_powerline_fonts = 1
let g:netrw_banner = 0
let mapleader = "\<Space>"

" refresh .vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>

" env specific things
nnoremap <leader>ss :term ++hidden ++open npm run start:local<CR>
nnoremap <leader>su :term ++hidden ++open npm run start-ui<CR>
nnoremap <leader>tfa :term ++hidden ++open npm run feature<CR>
nnoremap <leader>tfb :term ++hidden ++open npm run feature -- %<CR>
nnoremap <leader>tfi :term ++hidden ++open npm run ci-feature -- %<CR>
nnoremap <leader>tu :vert ter jest % --watch<CR>

" plugin mappings
nnoremap <F5> :MundoToggle<CR>
nnoremap <leader>i :SortImport<CR>

" experimental
"
" fuzzy searching with git ignore
map <leader>sf :call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --cached', 'sink': 'edit'}))<CR>
" search word under cursor
map <leader>s* :grep <cword> -R --exclude-dir=node_modules --exclude="node_modules/*" */**/src/*<CR>
" global search
map <leader>sl* :grep <cword> -R --exclude-dir=node_modules --exclude="node_modules/*" */**/src/*<CR>
" global search
fun! Grep( arg ) "{{{
    execute ':grep' a:arg '-R --exclude-dir=node_modules --exclude="node_modules/*" */**/src/*'
endfunction "}}}
command! -nargs=* Grep call Grep( '<args>' )

colorscheme molokai
set encoding=UTF-8
set hidden " buffer handling
set nowrap
set number
set shiftwidth=2
set updatetime=100 " vim-gitgutter option
syntax on

call plug#begin('~/.vim/plugged')
 
" extending vim language
Plug 'tpope/vim-commentary' " comment out things 'gc'
Plug 'tpope/vim-surround' " suround things ysiw ds' cs{ etc

" visual helpers
Plug 'airblade/vim-gitgutter' " self explanitory
Plug 'dense-analysis/ale' " syntax checking
Plug 'neoclide/coc.nvim' " intellisense
Plug 'ruanyl/vim-sort-imports' " this guy needs an accompanying install locally
Plug 'vim-airline/vim-airline' " git branch and file in the status line
Plug 'wsdjeg/vim-mundo' " undo history

" Bad ass tools
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy search
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-fugitive' " godly git powers
Plug 'tpope/vim-rhubarb' " GBrowse compatiblity, github issue completion

call plug#end()
