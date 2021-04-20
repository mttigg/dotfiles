" declare variables
let g:netrw_banner = 0
let g:netrw_fastbrowse = 0
let g:netrw_special_syntax= 1
let g:dirvish_mode = 'sort ,^.*[\/],'
let g:dirvish_git_show_icons = 1
set guifont=Fira\ Code

nnoremap <silent><buffer> <leader>f :%s/[^/]*\ze[^/]*[/]\=$/ &/g<CR>:sort ,^.*[\/],<CR>

function! QFuntracked()
    let flist = system('git ls-files --others --exclude-standard')
    let flist = split(flist, '\n')

    " Create the dictionaries used to populate the quickfix list
    let list = []
    for f in flist
        let dic = {'filename': f, "lnum": 1}
        call add(list, dic)
    endfor

    " Populate the qf list
    call setqflist(list)
endfunction
command QFuntracked call QFuntracked() 

augroup dirvish_config
  autocmd!

  autocmd FileType dirvish
    \ call dirvish#add_icon_fn({p -> WebDevIconsGetFileTypeSymbol(p, p[-1:]=='/')})


  " autocmd FileType dirvish
  "   \  nnoremap <silent><buffer> <CR> :call DirvishOpen()<CR>
  " autocmd FileType dirvish noremap
  "   \ <leader>d :!mkdr %
  " autocmd FileType dirvish noremap
  "   \ <leader>% :!touch %
  " autocmd FileType dirvish noremap
  "   \ <leader>R :!mv $ %

  " Map `gr` to reload.
  autocmd FileType dirvish nnoremap <silent><buffer>
    \ gr :<C-U>Dirvish %<CR>

  " Map `gh` to hide dot-prefixed files.  Press `R` to "toggle" (reload).
  autocmd FileType dirvish nnoremap <silent><buffer>
    \ gh :silent keeppatterns g@\v/\s\.[^\/]+/?$@d _<cr>:setl cole=3<cr>
augroup END

func Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc

let mapleader = "\<Space>"
let g:molokai_original = 1

" Abbreviations
ab import import<Space>{}<Space>from<Space>'<c-r>=Eatchar('\s')<cr>
ab tempr <Esc>:r ~/snippets/reactComponent.tsx<CR>ggdd
ab testreact <Esc>:r ~/snippets/testReactHook.tsx<CR>ggdd
ab testnest <Esc>:r ~/snippets/nestTest.ts<CR>ggdd/sut<Space>from<CR>wwa

" refresh .vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>

" -- FOLDING --
set foldmethod=syntax "syntax highlighting items specify folds
let javaScript_fold=1 "activate folding by JS syntax
set foldlevelstart=0 "start file with all folds opened

function! NeatFoldText()
  let foldchar         = " "
  let lines_count      = v:foldend - v:foldstart + 1
  let endline          = substitute(getline(v:foldend), " ", "", "g")
  let lines_count_text = printf(">>= %1s lines =<<", lines_count)
  let foldtextstart    = getline(v:foldstart) . " ••• " . endline
  let foldtextend      = lines_count_text . repeat(foldchar, 8)
  let foldtextlength   = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn

  " todo, show first line
  return foldtextstart . repeat(foldchar, winwidth(0) - foldtextlength) . foldtextend
endfunction

set foldtext=NeatFoldText()

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" scroll popup windows
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>p :CocCommand prettier.formatFile<CR>

set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" vim-rest-console
let g:vrc_curl_opts = {
  \ '-sS': '',
  \ '--connect-timeout': 10,
  \ '-i': '',
  \ '--max-time': 5,
  \ '-k': '',
\}

" env specific things
"
" run for all tests
nnoremap <leader>ta :call  CocAction('runCommand', 'jest.projectTest')<CR>
" test corresponding file
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>
nnoremap <leader>tt :call CocAction('runCommand', 'jest.fileTest', ['%:r.spec.%:e'])<CR>
" test current file
nnoremap <leader>t% :call  CocAction('runCommand', 'jest.fileTest', ['%'])<CR>
" test previous file
" nnoremap <leader>t# :vert ter jest # --watch<CR>
nnoremap <leader>t# :call  CocAction('runCommand', 'jest.fileTest', ['#'])<CR>

" plugin mappings
nnoremap <F5> :UndotreeToggle<CR>
nnoremap <leader>i :SortImport<CR>

autocmd ColorScheme * highlight Normal ctermbg=None
autocmd ColorScheme * highlight NonText ctermbg=None
autocmd ColorScheme * highlight Folded ctermbg=None
autocmd ColorScheme * highlight visual ctermbg=darkGrey
autocmd ColorScheme * highlight Folded ctermfg=Grey
autocmd ColorScheme * highlight Directory ctermfg=White
autocmd ColorScheme * highlight Pmenu ctermbg=darkGrey

" delete netrw buffers instead of hiding them
autocmd FileType netrw setl bufhidden=delete

"set variables
colorscheme molokai
let g:airline_theme = 'violet'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set encoding=UTF-8
set mouse=a
set undofile " permenent undo
set undodir=~/.vim/undo
set hidden " buffer handling
set wildmode=full
set wildmenu
set nowrap
set number
set shiftwidth=2
set previewpopup=height:200,width:100
syntax on
set tabstop=2

call plug#begin('~/.vim/plugged')

" do I like these?
Plug 'justinmk/vim-dirvish' " path navigator... 
Plug 'diepm/vim-rest-console'
 
" long live tpope
Plug 'tpope/vim-commentary' " comment out things 'gc'
Plug 'tpope/vim-surround' " suround things ysiw ds' cs{ etc
Plug 'tpope/vim-fugitive' " godly git powers
Plug 'tpope/vim-rhubarb' " GBrowse compatiblity, github issue completion
Plug 'tpope/vim-eunuch' " unix comands
Plug 'tpope/vim-vinegar' " netrw enhanced
Plug 'tpope/vim-sensible' " a standard for vim standard settings
Plug 'tpope/vim-repeat' " makes all these plugs repeatable
Plug 'tpope/vim-abolish' " better case handling
Plug 'tpope/vim-unimpaired' " standard mappings with [ & ]

" visual helpers
" :CocInstall coc-tsserver coc-git coc-json coc-prettier coc-explorer coc-eslint
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ruanyl/vim-sort-imports' " this guy needs an accompanying install locally
" requires Nerd-Font https://github.com/yanoasis/nerd-fonts#font-installation
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline' " git branch and file in the status line
Plug 'vim-airline/vim-airline-themes'
Plug 'mbbill/undotree' " undo history
Plug 'sheerun/vim-polyglot' " syntax highlighting for all languages

" Bad ass tools
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy search
Plug 'junegunn/fzf.vim' " more fuzzy search things


call plug#end()

" tag management, to make tags in fresh repo use $rg --files | ctags -R --links=no -L -
