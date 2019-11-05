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

" fzf in centered floating window, sources:
" https://github.com/junegunn/fzf.vim/issues/664#issuecomment-476438294
" https://github.com/neovim/neovim/issues/9718#issuecomment-546603628
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingBorderedFZF()' }

function! FloatingBorderedFZF()
    let width = min([&columns - 4, max([100, &columns - 40])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}
    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Normal
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

" terminal visual separator
" autocmd TermOpen term://* set foldcolumn=1

" whitespace rendering when enabled
set listchars=tab:⇥\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
