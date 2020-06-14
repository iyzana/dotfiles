set nocompatible

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

set hidden
set undofile

set lazyredraw
set inccommand=nosplit

set mouse=nv

" autosave
autocmd FocusLost * silent! wa
autocmd BufEnter term://* silent! wa
set autowriteall

" reduce update time
set updatetime=250

let g:coc_data_home=$HOME . '/.local/share/coc'
