set nocompatible

set number
set relativenumber

" use 4 spaces for indent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set autoindent
set smartindent

set ignorecase
set smartcase

set scrolloff=3

set splitbelow
set splitright

set hidden

set undofile

set noshowmode

" autosave
autocmd FocusLost * silent! wa
set autowriteall

" reduce update time for gitgutter
set updatetime=250
