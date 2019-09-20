" exit nerdtree with last split
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=40
let g:nerdtree_plugin_open_cmd = 'xdg-open'

" disable line numbers
set nonumber
set norelativenumber

" disable statusline
set laststatus=0
set noruler
set noshowmode

set shortmess+=c
set signcolumn=yes
set splitright

autocmd FileType fzf tnoremap <buffer> <Esc> <C-c>
