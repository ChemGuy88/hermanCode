" >>> Useful settings from freecodecamp.org >>>
" https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/
" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" <<< Useful settings from freecodecamp.org <<<

" >>> Herman's settings >>>
set fileformats=unix
set list
" Note the below line only works if you do `vim FILE_PATH`. Otherwise you get an error.
:e ++ff=unix
" <<< Herman's settings <<<
