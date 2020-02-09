" exit nerdtree with last split
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=40
let g:nerdtree_plugin_open_cmd = 'xdg-open'

set number

" disable statusline
set laststatus=0
set noruler
set noshowmode

set shortmess+=c
set signcolumn=yes
set splitright

let g:fzf_layout = { 'window': {'width': 0.7, 'height': 0.6 } }
let $FZF_DEFAULT_OPTS='--layout=reverse'

" terminal visual separator
" autocmd TermOpen term://* set foldcolumn=1

" whitespace rendering when enabled
set listchars=tab:⇥\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
