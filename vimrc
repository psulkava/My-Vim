set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

let &shell='/bin/zsh -i'

set nocompatible
filetype off

filetype plugin indent on    " required

let g:python3_host_prog = '/opt/homebrew/bin/python3.10'

" Gdiff default to vertical split
set diffopt+=vertical

set nofixendofline

let g:vue_disable_pre_processors=1

let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')

" automatically strip trailing whitespace on .py and .js files
autocmd BufWritePre *.js :%s/\s\+$//e
autocmd BufWritePre *.py :%s/\s\+$//e

" nerdcommenter options
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

let $BASH_ENV = "~/.bash_aliases" " enable aliases in Vim shell

syntax enable
set mouse=r
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab " 2 space tabs
set number              " line numbers
set ruler               " show column number
set showcmd             " show command in bottom bar"
set wildmenu            " visual autocomplete for command menu"
set ttyfast             " fast terminal connection
set lazyredraw          " redraw only when we need to."
set showmatch           " highlight matching [{()}]}]"

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set laststatus=2
set termencoding=utf-8
set encoding=utf-8

set clipboard=unnamed   " vim operations will work with mac clipboard

set exrc                " allow project specific vimrc files
set secure              " disable commands from being run from project specific vimrc files unless owned by me
set autoread            " autoreload a file when it changes on disk
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

let mapleader = ','
" turn off search highlight
nnoremap <Leader><Space> :nohlsearch<CR>
map <Leader><Space>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
map <Leader><Space>sh :!shipit<CR>

if &diff
    colorscheme solarized
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neomake/neomake'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-jedi'
Plug 'scrooloose/nerdcommenter'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'ap/vim-css-color'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
call plug#end()

let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let g:neomake_vue_enabled_makers = ['eslint']
let g:neomake_vue_eslint_args = ['--format=compact']
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let s:jshint_path = system('PATH=$(npm bin):$PATH && which jshint')
let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
let g:neomake_javascript_jshint_exe = substitute(s:jshint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
let g:neomake_vue_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

function! HasConfig(file, dir)
    return findfile(a:file, escape(a:dir, ' ') . ';') !=# ''
endfunction

augroup vimrc_autocmd
    autocmd!
    autocmd FileType javascript,javascript.jsx let g:neomake_javascript_enabled_makers =
        \ HasConfig('.eslintrc', expand('<amatch>:h')) ? ['eslint'] :
        \ HasConfig('.eslintrc.json', expand('<amatch>:h')) ? ['eslint'] :
        \ HasConfig('.jshintrc', expand('<amatch>:h')) ? ['jshint'] :
        \   ['eslint']
augroup END

call neomake#configure#automake('nrwi', 500)

let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'

nmap <Leader><Space>o :lopen<CR>    " open location window
nmap <Leader><Space>c :lclose<CR>   " close location window
nmap <Leader><Space>, :ll<CR>       " go to current error/warning
nmap <Leader><Space>n :lnext<CR>    " next error/warning
nmap <Leader><Space>p :lprev<CR>    " previous error/warning
