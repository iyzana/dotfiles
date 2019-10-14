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

" fzf in centered floating window
" from https://github.com/junegunn/fzf.vim/issues/664#issuecomment-476438294
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)

  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 1,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
  call setbufvar(buf, '&signcolumn', 'yes')
endfunction
