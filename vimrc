set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

colorscheme badwolf
syntax enable
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab " 4 space tabs
set number              " line numbers
set showcmd             " show command in bottom bar"
set cursorline          " highlight current line"
set wildmenu            " visual autocomplete for command menu"
set lazyredraw          " redraw only when we need to."
set showmatch           " highlight matching [{()}]}]"

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

let mapleader = ','
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
