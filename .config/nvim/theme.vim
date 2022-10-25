" show highlight group under cursor
" nmap <leader>sp :call <SID>SynStack()<CR>
" function! <SID>SynStack()
"   if !exists("*synstack")
"     return
"   endif
"   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunc

" show all highlight groups
" :so $VIMRUNTIME/syntax/hitest.vim

" darcula + gitgutter
" hi! link GitGutterAdd GitAddStripe
" hi! link GitGutterChange GitChangeStripe
" hi! link GitGutterDelete GitDeleteStripe
" let g:gitgutter_sign_removed = '▶'

" darcula + coc
" hi! link CocErrorSign ErrorSign
" hi! link CocWarningSign WarningSign
" hi! link CocInfoSign InfoSign
" hi! link CocHintSign InfoSign
" hi! link CocErrorFloat Pmenu
" hi! link CocWarningFloat Pmenu
" hi! link CocInfoFloat Pmenu
" hi! link CocHintFloat Pmenu
" hi! link CocHighlightText IdentifierUnderCaret
" hi! link CocHighlightRead IdentifierUnderCaret
" hi! link CocHighlightWrite IdentifierUnderCaretWrite
" hi! link CocErrorHighlight CodeError
" hi! link CocWarningHighlight CodeWarning
" hi! link CocInfoHighlight CodeInfo
" hi! link CocHintHighlight CodeHint
