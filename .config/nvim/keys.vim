" split navigation
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" terminal navigation
tnoremap <C-h> <C-\><C-n><C-w><C-h>
tnoremap <C-j> <C-\><C-n><C-w><C-j>
tnoremap <C-k> <C-\><C-n><C-w><C-k>
tnoremap <C-l> <C-\><C-n><C-w><C-l>
tnoremap <Esc> <C-\><C-n>
autocmd BufEnter term://* startinsert

" custom mappings
let mapleader=" "
nnoremap <silent> <leader>n :noh<CR>
nnoremap <silent> <leader>c :wa<CR>:80vs +terminal<CR>a
nnoremap <C-6> <C-^>
vnoremap > >gv
vnoremap < <gv
nnoremap Q @@

" fzf
nnoremap <C-p> :Files<CR>
nnoremap <leader>p :AllFiles<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <C-b> :Buffers<CR>
autocmd FileType fzf tnoremap <buffer> <Esc> <C-c>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \           fzf#vim#with_preview('right:50%:hidden', '´'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%:hidden', '´'), <bang>0)

command! -bang -nargs=* AllFiles
  \ call fzf#run(
  \   fzf#wrap(
  \     fzf#vim#with_preview(
  \       {'source': 'fd --type f --no-ignore '.shellescape(<q-args>)},
  \       'right:50%:hidden',
  \       '´'
  \     )
  \   )
  \ )

" nerdtree
map <silent><leader>t :NERDTreeFind<CR>
map <silent><leader>o :NERDTreeToggle<CR>

nmap <silent> go :Alternate<CR>

nmap <silent> go :Alternate<CR>

" linting / doc / navigation
nmap <silent> <leader>k <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>j <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> K :call <SID>show_documentation()<CR>
imap <silent> <C-P> <C-O>:call CocActionAsync('showSignatureHelp')<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" refactoring
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>f <Plug>(coc-format)
nmap <leader>qf <Plug>(coc-fix-current)
nmap <leader>a v<Plug>(coc-codeaction-selected)
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <A-CR> v<Plug>(coc-codeaction-selected)
vmap <A-CR> <Plug>(coc-codeaction-selected)

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nmap <silent> <S-TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select)
