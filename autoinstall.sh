#!/bin/sh
# written by https://github.com/nvie

INSTALL_TO=~/Projects

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

install_vimrc () {
    [ -e "$INSTALL_TO/My-Vim" ] && die "$INSTALL_TO/My-Vim already exists."
    [ -e "~/.vim" ] && die "~/.vim already exists."
    [ -e "~/.vimrc" ] && die "~/.vimrc already exists."

    cd "$INSTALL_TO"
    git clone git://github.com/psulkava/My-Vim.git
    cd My-Vim

    # Download vim plugin bundles
    git submodule init
    git submodule update

    # Symlink ~/.vim and ~/.vimrc
    cd ~
    ln -s "$INSTALL_TO/My-Vim/vimrc" .vimrc
    ln -s "$INSTALL_TO/My-Vim/vim" .vim
    touch ~/.vim/user.vim

    echo "Installed and configured .vim, have fun."
}

install_vimrc
