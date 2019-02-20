let $PATH = $PATH . ':' . expand("~/.cabal/bin")
set rtp+=/Users/grant/homebrew/share/vim/vim74

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle plugin management
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Bundle 'gmarik/Vundle.vim'

" Bundle "coot/atp_vim"
" Bundle "myusuf3/numbers.vim"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "Shougo/neocomplete.vim"
Bundle "Shougo/vimproc.vim"
Bundle "Twinside/vim-haskellConceal"
Bundle "bronson/vim-trailing-whitespace"
Bundle "ctrlpvim/ctrlp.vim"
Bundle "davidhalter/jedi-vim"
Bundle "eagletmt/ghcmod-vim"
Bundle "eagletmt/neco-ghc"
Bundle "fatih/vim-go"
Bundle "flazz/vim-colorschemes"
Bundle "garbas/vim-snipmate"
Bundle "godlygeek/tabular"
Bundle "honza/vim-snippets"
Bundle "kmees/vim-specky"
Bundle "lervag/vimtex"
Bundle "lukerandall/haskellmode-vim"
Bundle "rizzatti/dash.vim"
Bundle "rodjek/vim-puppet"
Bundle "scrooloose/syntastic"
Bundle "sheerun/vim-polyglot"
Bundle "szw/vim-tags"
Bundle "terryma/vim-multiple-cursors"
Bundle "tomtom/tlib_vim"
Bundle "tpope/vim-commentary"
Bundle "tpope/vim-obsession"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-git"
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-unimpaired"
Bundle "vim-airline/vim-airline"
Bundle "vim-airline/vim-airline-themes"
Bundle "vim-ruby/vim-ruby"

" All of your Plugins must be added before the following line
call vundle#end()            " required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype on
filetype plugin indent on    " required

function! s:RepeatChar()
    echo "Char to insert = "
    let l:char = nr2char(getchar())

    let l:str = repeat(l:char, v:count+1)
    echom "[RepeatChar] Repeating '" . l:char . "', " . (v:count+1) . " times: " . l:str
    return "\<c-u>normal! i" . l:str
endfunction

function! SetToCabalBuild()
    if glob("*.cabal") != ''
        set makeprg=cabal\ build
    endif
endfunction

function! s:rspec_complete(findstart, base)
    let lnum = line('.')
    let column = col('.')
    let line = strpart(getline('.'), 0, column - 1)
endfunction

function! s:GoConfig()
    set et ts=4 sw=4
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.go = '[^.[:digit:] *\t]\.'
    let g:neocomplete#enable_auto_select = 1

    if isdirectory(expand("~/.vim/bundle/vim-go"))
        let g:go_fmt_fail_silently = 1
        let g:go_fmt_command = "gofmt"
        let g:go_highlight_functions = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_structs = 1
    endif
    nmap <F8> :TagbarToggle<CR>
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }
    compiler go
endfunction

function! s:RubyConfig()
    set et ts=2 sw=2
    set omnifunc=rubycomplete#Complete
    let g:rubycomplete_buffer_loading = 1
    let g:rubycomplete_classes_in_global = 1
    let g:rubycomplete_rails = 1
    compiler ruby
endfunction

augroup Development
    au!
    au FileType gitcommit set tw=70
    au FileType ruby :call <SID>RubyConfig()
    " au BufReadPost,BufNewFile *_spec.rb set syntax=rspec
    au FileType yaml set et ts=2 sw=2
    au FileType json set et ts=2 sw=2 omnifunc=jsoncomplete#CompletePacker
augroup END

" Auto-checking on writing
autocmd BufWritePost *.hs,*.lhs GhcModCheckAndLintAsync

augroup Go
    au!
    au BufWritePost *.go GoImports
    au BufWritePost *.go GoBuild
    au FileType go :call <SID>GoConfig()
    au FileType go nmap <leader>s <Plug>(go-implements)
    au FileType go nmap <leader>i <Plug>(go-info)
    au FileType go nmap <leader>gd <Plug>(go-doc)
    au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
    au FileType go nmap <leader>gb <Plug>(go-doc-browser)
    au FileType go nmap <leader>r <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <leader>c <Plug>(go-coverage)
    au FileType go nmap <leader>aa :GoAlternate<CR>
    au FileType go nmap <buffer> <leader>as <Plug>(go-alternate-split)
    au FileType go nmap <buffer> <leader>av <Plug>(go-alternate-vertical)
augroup END

augroup HaskellGroup
"  neocomplcache (advanced completion)
    au!
    autocmd BufEnter *.hs,*.lhs let g:neocomplcache_enable_at_startup = 1
    autocmd BufEnter *.hs,*.lhs :call SetToCabalBuild()
augroup END

augroup PythonGroup
    au!
    " au FileType python setlocal omnifunc=pythoncomplete#Complete
    au FileType python setlocal completeopt-=longest,preview
    au FileType python let g:jedi#auto_vim_configuration=0
augroup END

augroup VimGroup
    au!
    au BufWritePost $MYVIMRC :source %
augroup END

set modelines=5
syntax on
set tw=76
set et
set sw=4
set ts=4
abbreviate £ #
set pastetoggle=<F3>
let mapleader = ','
let localleader = ','
set number relativenumber

colorscheme molokai
"set rulerformat='%-14.(%l,%c%V%)\ %P'
"set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set laststatus=2
set omnifunc=syntaxcomplete#Complete
set completeopt=preview,menu
" let g:airline_powerline_fonts = 1
set statusline+=%{fugitive#statusline()}
set statusline+=%{ObsessionStatus()}
let g:airline_theme = "wombat"
let g:airline#extensions#branch#enabled=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:rubycomplete_load_gemfile = 1
let g:rubycomplete_buffer_loading = 1
let g:haddock_browser = "/Applications/Firefox"
let g:puppet_align_hashes = 0       " conflicts with snipMate puppet snippets
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map={'mode': 'active', 'passive_filetypes': ['haskell']}

" Autocompletion
let g:jedi#popup_select_first = 0
let g:haskellmode_completion_ghc = 1
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

let g:necoghc_enable_detailed_browse = 0
set tags=tags;/,codex.tags;/
map <leader>tg :!codex update --force<CR>
set csto=1 " search codex tags first
set cst
set csverb
nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
" nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

" Autocomplete already-existing words in the file with tab (extremely useful!)
" function! InsertTabWrapper()
"       let col = col('.') - 1
"       if !col || getline('.')[col - 1] !~ '\k'
"           return "\<tab>"
"       else
"           return "\<c-p>"
"       endif
" endfunction
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^.[:digit:] *\t]\%(\.\|->\)'

" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

map <silent> <Leader>d <Plug>DashSearch
nmap <Leader>$$ :%s/.* \([^ ]*\)/\1/<CR>
nnoremap <Leader>t] :tabnext<CR>
nnoremap <Leader>t[ :tabprevious<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
nnoremap <Leader>o :only<cr>
nnoremap <F7> mzgg=G<CR>
nnoremap <F8> }mz{='z<CR>
inoremap jk <esc>
cnoremap <c-g> <esc>
nnoremap ; :
nnoremap <Leader>h :help <c-r>=expand('<cword>')<cr><cr>
nnoremap <Leader>H :help <c-r>=expand('<cWORD>')<cr><cr>
" nnoremap <silent> cc :<c-r>=<SID>RepeatChar()<cr>

" Reformat and align puppet resource blocks
" (requires vim-puppet and tabular plugins)
" nnoremap == /=><cr>viB=j,a=>}

" Tabularize {
if isdirectory(expand("~/.vim/bundle/tabular"))
    nmap <Leader>a& :Tabularize /&<CR>
    vmap <Leader>a& :Tabularize /&<CR>
    nmap <Leader>a- :Tabularize /-<CR>
    vmap <Leader>a- :Tabularize /-<CR>
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a=> :Tabularize /=><CR>
    vmap <Leader>a=> :Tabularize /=><CR>
    nmap <Leader>a-> :Tabularize /-><CR>
    vmap <Leader>a-> :Tabularize /-><CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a,, :Tabularize /,\zs<CR>
    vmap <Leader>a,, :Tabularize /,\zs<CR>
    nmap <Leader>a" :Tabularize /"<CR>
    vmap <Leader>a" :Tabularize /"<CR>
    nmap <Leader>a# :Tabularize /#<CR>
    vmap <Leader>a# :Tabularize /#<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
endif
" }

" imap <tab> <Plug>snipMateNextOrTrigger
" Vim Tags {
if isdirectory(expand("~/.vim/bundle/vim-tags"))
    let g:vim_tags_auto_generate = 1
    let g:vim_tags_ctags_binary = "/usr/bin/ctags"
    " let g:vim_tags_project_tags_command = "{CTAGS} {OPTIONS} {DIRECTORY} 2>/dev/null"
    " let g:vim_tags_gems_tags_command = "{CTAGS} {OPTIONS} `bundle show --paths` 2>/dev/null"
    let g:rubycomplete_load_gemfile = 1
    let g:rubycomplete_buffer_loading = 1
endif

" Fugitive {
if isdirectory(expand("~/.vim/bundle/vim-fugitive"))
    noremap <Leader>gs :Gstatus<CR>
    noremap <Leader>gc :Gcommit<CR>
    noremap <Leader>gb :Gbrowse<CR>
    noremap <Leader>gw :Gwrite<CR>
    noremap <Leader>gr :Gread<CR>
    noremap <Leader>gB :Gblame<CR>
endif
" }

" " Neocompletion {
if isdirectory(expand("~/.vim/bundle/neocomplete"))
    let g:neocomplete#enable_at_startup = 1
    " inoremap <expr><C-g> neocomplete#undo_completion()
    " inoremap <expr><C-l> neocomplete#complete_common_string()

    " if !exists('g:neocomplete#sources#omni#input_patterns')
    "     let g:neocomplete#sources#omni#input_patterns = {}
    " endif
    " let g:neocomplete#enable_refresh_always = 0
    " let g:neocomplete#enable_auto_close_preview = 1
    " let g:neocomplete#enable_smart_case = 0
    " call neocomplete#custom#source('_', 'sorters', [])
    " let g:neocomplete#sources#dictionary#dictionaries = {
    "             \ 'default' : '',
    "             \ 'vimshell' : $HOME.'/.vimshell_hist'
    "             \ }
endif
" " }

hi Pmenu ctermbg=8
hi PmenuSel ctermbg=1
hi PmenuSbar ctermbg=0

" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-g>u\<Tab>"
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" neocomplete
if isdirectory(expand("~/.vim/bundle/neocomplete.vim"))
    let g:neocomplete#enable_at_startup = 1
    " Set minimum syntax keyword length.
    " let g:neocomplete#sources#syntax#min_keyword_length = 3
    inoremap <expr><C-g> neocomplete#undo_completion()
endif

" Handy stuff
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
iabbrev _date <C-r>=strftime("%A, %d %B %Y %H:%M %Z")<cr>
set wildmenu
set wildmode=longest:full,full

set secure
