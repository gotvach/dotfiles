let $PATH = $PATH . ':' . expand("~/.cabal/bin")
" set rtp+=/Users/grant/homebrew/share/vim/vim74

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle plugin management
let g:polyglot_disabled = [ 'haskell', 'ftdetect' ]

"filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/autoload/plug.vim

call plug#begin('~/.vim/plugged')
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/vimproc.vim'
Plug 'Twinside/vim-haskellConceal'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go'
Plug 'flazz/vim-colorschemes'
Plug 'garbas/vim-snipmate'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf'
Plug 'kmees/vim-specky'
Plug 'lervag/vimtex'
Plug 'liuchengxu/vista.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'rizzatti/dash.vim'
Plug 'rodjek/vim-puppet'
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'szw/vim-tags'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'

" All of your Plugins must be added before the following line
call plug#end()            " required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on
filetype plugin indent on    " required
colorscheme molokai

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
    if isdirectory(expand("~/.vim/plugged/vim-go"))
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

augroup Colors
    autocmd!
    autocmd ColorScheme * call ColorHighlights()
augroup END

" 
function! ColorHighlights() abort
    " highlight MyLspErrorText ctermfg=203 ctermbg=235 guifg=#E5786D guibg=#242424
    highlight MyLspErrorText ctermfg=203 ctermbg=235 guifg=#E5786D
    highlight LspErrorText term=standout ctermfg=darkred ctermbg=darkred guifg=#cc0000 guibg=#242424
    " highlight link LspErrorVirtualText MyLspErrorText
    highlight link LspErrorHighlight MyLspErrorText
    highlight clear LspWarningLine
    highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green
    highlight lspReference guibg=#303010
endfunction

augroup Development
    au!
    au FileType gitcommit set tw=70
    au FileType ruby :call <SID>RubyConfig()
    " au BufReadPost,BufNewFile *_spec.rb set syntax=rspec
    au FileType yaml set et ts=2 sw=2
    au FileType json set et ts=2 sw=2 omnifunc=jsoncomplete#CompletePacker
augroup END

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
    au!
    autocmd BufEnter *.hs,*.lhs :call SetToCabalBuild()

    if executable('haskell-language-server-wrapper')
        au User lsp_setup call lsp#register_server({
        \ 'name': 'haskell',
        \ 'cmd': {server_info->['haskell-language-server-wrapper', '--lsp']},
        \ 'allowlist': ['haskell'],
        \ })
    endif
augroup END

" Original source: https://dev.to/moniquelive/haskell-lsp-bonus-for-vim-4nlj
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gf <plug>(lsp-code-action)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <F2> <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    xmap <buffer> f <plug>(lsp-document-range-format)
    nmap <buffer> <F5> <plug>(lsp-code-lens)

    " buffer format on save
    " autocmd BufWritePre <buffer> LspDocumentFormatSync
endfunction

" Original source: https://dev.to/moniquelive/haskell-lsp-bonus-for-vim-4nlj
augroup LspInstall
    au!
    let g:lsp_signs_enabled = 1         " enable signs
    let g:lsp_diagnostics_highlights_enabled = 1
    let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
    let g:lsp_diagnostics_signs_error = {'text': '✗'}
    " let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GUI
    " let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'} " icons require GUI
    let g:lsp_diagnostics_signs_warning = {'text': '‼'}
    let g:lsp_highlight_references_enabled = 1

    " highlight link LspErrorText GruvboxRedSign " requires gruvbox

    " Need to override colorscheme prior to loading LSP
    " highlight LspErrorText guifg=red guibg=red
    " highlight link LspErrorVirtualText ErrorMsg
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
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
set termguicolors

"set rulerformat='%-14.(%l,%c%V%)\ %P'
"set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set laststatus=2
set omnifunc=syntaxcomplete#Complete
" set completeopt=preview,menu
set completeopt=menu
set statusline+=%{fugitive#statusline()}
set statusline+=%{ObsessionStatus()}

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_theme = "wombat"
let g:airline#extensions#branch#enabled=1

let g:rubycomplete_load_gemfile = 1
let g:rubycomplete_buffer_loading = 1
let g:haddock_browser = "/Applications/Firefox"
let g:puppet_align_hashes = 0       " conflicts with snipMate puppet snippets
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map={'mode': 'active', 'passive_filetypes': ['haskell']}
let g:vista_sidebar_width = 50
let g:vista_default_executive = 'vim_lsp'

let g:tex_flavor = 'latex'

" Autocompletion
let g:jedi#popup_select_first = 0
let g:haskellmode_completion_ghc = 0
let g:acp_enableAtStartup = 0

if isdirectory(expand('~/.vim/plugged/asyncomplete.vim'))
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
    " inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"
    imap <c-space> <Plug>(asyncomplete_force_refresh)

    " Default
    " let g:asyncomplete_auto_popup = 0
endif

set tags=tags;/,codex.tags;/
map <leader>tg :!codex update --force<CR>
set csto=1 " search codex tags first
set cst
set csverb

map <silent> <Leader>d <Plug>DashSearch
nmap <Leader>$$ :%s/.* \([^ ]*\)/\1/<CR>
nnoremap <Leader>t] :tabnext<CR>
nnoremap <Leader>t[ :tabprevious<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
nnoremap <Leader>o :only<cr>
nnoremap <Leader>c :close<cr>
nnoremap <F7> mzgg=G<CR>
nnoremap <F8> }mz{='z<CR>
inoremap jk <esc>
cnoremap <c-g> <esc>
nnoremap ; :
nnoremap <Leader>h :help <c-r>=expand('<cword>')<cr><cr>
nnoremap <Leader>H :help <c-r>=expand('<cWORD>')<cr><cr>
nnoremap <silent> <C-\> :Vista!!<CR>
" nnoremap <silent> cc :<c-r>=<SID>RepeatChar()<cr>

" Reformat and align puppet resource blocks
" (requires vim-puppet and tabular plugins)
" nnoremap == /=><cr>viB=j,a=>}

" Tabularize {
if isdirectory(expand("~/.vim/plugged/tabular"))
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
if isdirectory(expand("~/.vim/plugged/vim-tags"))
    let g:vim_tags_auto_generate = 1
    let g:vim_tags_ctags_binary = "/usr/bin/ctags"
    " let g:vim_tags_project_tags_command = "{CTAGS} {OPTIONS} {DIRECTORY} 2>/dev/null"
    " let g:vim_tags_gems_tags_command = "{CTAGS} {OPTIONS} `bundle show --paths` 2>/dev/null"
    let g:rubycomplete_load_gemfile = 1
    let g:rubycomplete_buffer_loading = 1
endif

" Fugitive {
if isdirectory(expand("~/.vim/plugged/vim-fugitive"))
    noremap <Leader>gs :Gstatus<CR>
    noremap <Leader>gc :Gcommit<CR>
    noremap <Leader>gb :Gbrowse<CR>
    noremap <Leader>gw :Gwrite<CR>
    noremap <Leader>gr :Gread<CR>
    noremap <Leader>gB :Gblame<CR>
endif
" }

hi Pmenu ctermbg=8
hi PmenuSel ctermbg=1
hi PmenuSbar ctermbg=0

" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-g>u\<Tab>"
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Handy stuff
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
iabbrev _date <C-r>=strftime("%A, %d %B %Y %H:%M %Z")<cr>
set wildmenu
set wildmode=longest:full,full

set secure

abbreviate :branch: 
