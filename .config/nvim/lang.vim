" prose
set spelllang=en,de_20,hun-de-DE-frami
autocmd Filetype markdown,tex setlocal spell
autocmd Filetype markdown,tex setlocal colorcolumn=100
autocmd Filetype markdown,tex setlocal textwidth=100
autocmd Filetype markdown,yaml,javascript,typescript setlocal tabstop=2
autocmd Filetype markdown,yaml,javascript,typescript setlocal shiftwidth=2

" tex
let g:tex_flavor = 'latex'
let g:polyglot_disabled = ['latex']
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {
    \ 'continuous': 0,
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \   '-shell-escape',
    \ ],
  \ }

" \   '-output-directory=build',

" nav
let g:AlternatePath = []
let g:AlternateExtensionMappings = [{
  \ '.js': '.ts',
  \ '.ts': '.tsx',
  \ '.tsx': '.html',
  \ '.html': '.css',
  \ '.css': '.scss',
  \ '.scss': '.js',
\ }]
nmap <silent> ga :Alternate<CR>

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

autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" refactoring
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>f <Plug>(coc-format)
nmap <leader>qf <Plug>(coc-fix-current)
nmap <leader>a v<Plug>(coc-codeaction-selected)
nmap <A-CR> v<Plug>(coc-codeaction-selected)

" completion
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nmap <silent> <S-TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select)
