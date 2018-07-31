set nocompatible
filetype off

" include powerline vim plugin
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" syntax highlighting for a ton of languages
Plugin 'sheerun/vim-polyglot'

" syntax error checking
Plugin 'vim-syntastic/syntastic'

" auto complete
Plugin 'Valloric/YouCompleteMe'

" easy and sexy commenting
Plugin 'scrooloose/nerdcommenter'

" easy surrounding with parantheses, brackets, quotes, XML tags, etc.
Plugin 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:polyglot_disabled = ['css', 'less']

" syntastic options
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = []

let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
let b:syntastic_vue_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

augroup vimrc_autocmd
    autocmd!
    autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') !=# '' ? ['eslint'] : ['jshint']
augroup END

" nerdcommenter options
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

let $BASH_ENV = "~/.bash_aliases" " enable aliases in Vim shell

syntax enable
set ttymouse=xterm2
set mouse=r
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab " 4 space tabs
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

if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

let mapleader = ','
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
map <leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
map <leader>ll :lnext<CR>
map <leader>lp :lprev<CR>
map <leader>lj :lclose<CR>
map <leader>sh :!shipit<CR>
