set runtimepath^=~/.local/share/nvim/plugged runtimepath+=~/.local/share/nvim/plugged/after
let &packpath = &runtimepath

"""""""""""
" General "
"""""""""""
let localleader= ','
let mapleader = ','
set autoread
set background=dark
set completeopt=longest,menuone,preview
set foldmethod=marker
set updatetime=100
set laststatus=2
set number relativenumber
set omnifunc=syntaxcomplete#Complete
set pastetoggle=<F3>
set t_Co=256
set tabstop=4 shiftwidth=4 expandtab
set showmatch
set matchtime=3
set hidden
set secure

iabbrev _date_ <C-r>=strftime("%A, %d %B %Y %H:%M %Z")<cr>

"""""""""""
" Plugins "
"""""""""""

call plug#begin('~/.local/share/nvim/plugged')
" call plug#begin('~/.neovim/plugged')
if has('nvim')
    " Completion
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    "Plug 'eagletmt/neco-ghc'       " Haskell completion
    Plug 'zchee/deoplete-jedi'      " Python completion
    Plug 'zchee/deoplete-go'        " Go completion
"	Plug 'python-mode/python-mode', { 'branch': 'develop' }
    Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
    Plug 'Shougo/neco-vim'          " VIM command completion
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }

    Plug 'neomake/neomake'
    Plug 'Shougo/neco-syntax'

    " Display
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
endif

Plug 'airblade/vim-gitgutter'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'brooth/far.vim'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ncm2/ncm2-ultisnips'
Plug 'kmees/vim-specky'
Plug 'rizzatti/dash.vim'
Plug 'rodjek/vim-puppet'
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'szw/vim-tags'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'

call plug#end()

"""""""""""""""
" Colorshemes "
"""""""""""""""

" colorscheme antares
" colorscheme CandyPaper
" colorscheme DevC++
" colorscheme Light
" colorscheme LightDefault
" colorscheme monokai
" colorscheme PaperColor
" colorscheme revolution
" colorscheme Tomorrow-Night
" colorscheme Tomorrow-Night-Eighties
" colorscheme wombat256i
" colorscheme zen
" colorscheme zenburn
" colorscheme znake
colorscheme molokai

""""""""""""""""
" Plugin Setup "
""""""""""""""""

if isdirectory(expand("~/.vim/bundle/vim-tags"))
    let g:vim_tags_auto_generate = 1
    let g:vim_tags_ctags_binary = "/usr/bin/ctags"
    " let g:vim_tags_project_tags_command = "{CTAGS} {OPTIONS} {DIRECTORY} 2>/dev/null"
    " let g:vim_tags_gems_tags_command = "{CTAGS} {OPTIONS} `bundle show --paths` 2>/dev/null"
    let g:rubycomplete_load_gemfile = 1
    let g:rubycomplete_buffer_loading = 1
endif

"""""""""""""
" Variables "
"""""""""""""
" See output of :checkhealth

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['ultisnips','LanguageClient']
" let g:LanguageClient_loggingFile="/Users/grant/language-client.log"
" let g:LanguageClient_loggingLevel="INFO"
let g:LanguageClient_serverCommands = {
    \ 'dockerfile': ['docker-langserver', '--stdio'],
    \ 'python': ['/Users/grant/.pyenv/versions/pyls'],
    \ 'go': ['/Users/grant/Projects/go/bin/go-langserver', '-gocodecompletion'],
    \ 'groovy': [''],
    \ }
let g:lightline = {
    \   'colorscheme': 'deus',
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ],
    \                 [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
    \   },
    \   'component_function': {
    \       'fugitive': 'fugitive#head'
    \   }
    \ }
let g:pymode_python = 'python3'
let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

if !exists('g:necovim#complete_functions')
    let g:necovim#complete_functions = {}
endif
let g:necovim#complete_functions.Ref = 'ref#complete'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map={'mode': 'active', 'passive_filetypes': ['haskell']}
let g:syntastic_puppet_puppet_args = '--parser=future'
let g:syntastic_yaml_checkers = ['yamllint']

let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsListSnippets = "<C-l>"
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsListSnippets = "<C-tab>"

let g:tex_flavor = 'latex'

""""""""""
" Groups "
""""""""""

" Autocomplete
augroup AutocompleteGroup
    au!
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" Language
augroup LanguageGroup
    au!
    autocmd FileType * call LC_maps()
    autocmd FileType python call deoplete#custom#option('sources', {
                \ 'python': ['LanguageClient'],
                \ })
    autocmd FileType gitcommit set tw=70
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd FileType json set et ts=2 sw=2 omnifunc=jsoncomplete#CompletePacker
    autocmd FileType ruby :call <SID>RubyConfig()
    autocmd FileType yaml set et ts=2 sw=2
augroup END

augroup Snippets
    au!
    autocmd FileType json :call UltiSnips#AddFiletypes('packer')
augroup END

augroup Vim
    au!
    autocmd BufWritePost ~/.config/nvim/init.vim :source %
augroup END

augroup YAML
    au!
    autocmd BufReadPost *.eyaml setlocal ft=yaml | call <SID>yamlSetup()
    autocmd FileType yaml :call <SID>yamlSetup()
augroup END

"""""""""""
" Keymaps "
"""""""""""

" Autocomplete
" imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" Editor config
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<CR>
nnoremap <leader>eg :vsplit ~/.gitconfig<CR>

" FZF
nnoremap <C-p> :Files<CR>

" LanguageClient ?
nnoremap [e :cprevious<CR>
nnoremap ]e :cnext<CR>

" NERDTree same as Atom - <Alt-\>
if has('mac')
    map « :NERDTreeToggle<CR>
    " GitGutterToggle - <Alt-g>
    map © :GitGutterToggle<CR>
elseif has('unix')
    map <A-\> :NERDTreeToggle<CR>
    map <A-g> :GitGutterToggle<CR>
endif

" Text manipulation or tooling
nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>

"""""""""""""
" Functions "
"""""""""""""

" LanguageClient
function! LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
        nnoremap <F5> :call LanguageClient_contextMenu()<CR>
        nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
        nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
        nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    endif
endfunction

function! s:RubyConfig()
    set et ts=2 sw=2
    set omnifunc=rubycomplete#Complete
    let g:rubycomplete_buffer_loading = 1
    let g:rubycomplete_classes_in_global = 1
    let g:rubycomplete_rails = 1
    compiler ruby
endfunction

function! s:yamlSetup()
    setlocal foldmarker=s+[\"\]'a-z]*:,s+[\"\'a-z]*:
    setlocal foldmethod=indent
    setlocal foldlevel=0
    setlocal foldlevelstart=0
    setlocal foldenable
endfunction

""""""""""""""""""""""""""""""
" Overrides / customisations "
""""""""""""""""""""""""""""""
" fzf's preview use of Ag: https://stackoverflow.com/a/50730458
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview(),
  \                 <bang>0)
