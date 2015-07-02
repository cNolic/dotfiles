set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
call vundle#end()            " required
filetype plugin indent on    " required


let mapleader = " "
set nobackup
set nowritebackup
set noswapfile
set history=50
set incsearch " Always display the status line 
set laststatus=2

" Colors
syntax enable
set background=dark
colorscheme solarized


" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab


" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

set number
