set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
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
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set t_Co=256
set background=dark
colorscheme solarized
syntax enable
set ttymouse=xterm2
set mouse=a
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab " 4 space tabs
set number              " line numbers
set ruler               " show column number
set showcmd             " show command in bottom bar"
set cursorline          " highlight current line"
set wildmenu            " visual autocomplete for command menu"
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
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
