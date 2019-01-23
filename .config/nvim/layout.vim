" exit nerdtree with last split
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" open nerdtree on start
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd w
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=40
let g:nerdtree_plugin_open_cmd = 'xdg-open'

" disable statusline in fzf split
autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler
autocmd FileType fzf tnoremap <buffer> <Esc> <C-c>
