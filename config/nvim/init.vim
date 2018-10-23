" set runtimepath^=~/.neovim runtimepath+=~/.neovim/after
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

"""""""""""
" Plugins "
"""""""""""

call plug#begin('~/.local/share/nvim/plugged')
if has('nvim')
    " Completion
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    "Plug 'eagletmt/neco-ghc'       " Haskell completion
    Plug 'zchee/deoplete-jedi'      " Python completion
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
Plug 'brooth/far.vim'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'rizzatti/dash.vim'
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

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

"""""""""""""
" Variables "
"""""""""""""
" See output of :checkhealth

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources#python = ['ultisnips']
let g:LanguageClient_serverCommands = {
    \ 'dockerfile': ['docker-langserver', '--stdio'],
    \ 'python': ['~/.pyenv/versions/pyls/bin/pyls'],
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
let g:python_host_prog  = '/Users/grant/.pyenv/versions/py2neovim/bin/python'
let g:python3_host_prog = '/Users/grant/.pyenv/versions/py3neovim/bin/python'

if !exists('g:necovim#complete_functions')
    let g:necovim#complete_functions = {}
endif
let g:necovim#complete_functions.Ref = 'ref#complete'
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsListSnippets = "<C-l>"
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsListSnippets = "<C-tab>"

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

" FZF
nnoremap <C-p> :Files<CR>

" LanguageClient ?
nnoremap [e :cprevious<CR>
nnoremap ]e :cnext<CR>

" NERDTree same as Atom - <Alt-\>
map « :NERDTreeToggle<CR>

" GitGutterToggle - <Alt-g>
map © :GitGutterToggle<CR>

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

""""""""""""""""""""""""""""""
" Overrides / customisations "
""""""""""""""""""""""""""""""
" fzf's preview use of Ag: https://stackoverflow.com/a/50730458
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview(),
  \                 <bang>0)
