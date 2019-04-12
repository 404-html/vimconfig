"DO NOT use folding. It makes autocompletion extremely slow
"" use folding if we can
"if has ('folding')
"  set foldenable
"  set foldmethod=marker
"  set foldmarker={{{,}}}
"  "set foldcolumn=0
"  " need this set to something > 0 for the mouse to work
"  set foldcolumn=2
"  set foldminlines=10
"  " start with 10 folds opened (ideally all)
"  set foldlevel=10
"endif

" setting foldmethod to manual speeds up vim auto-completion drastically
set foldmethod=manual

" easier navigation for reading code
" all c++ stuff
nnoremap ]t ]]ztzo
nnoremap [t [[ztzo
nnoremap t]j ]czt
" disable when in diff mode or change to ]]zt
" @= is the expression register (fix multiplyer)
" type :he :map and scan for Multiplying a count
nnoremap zj @='2zjzozt'<CR>

" this disables eclim's auto Validate
" What if eclim isn't installed though? Make it silent
"autocmd! BufWritePost <buffer> silent! autocmd! eclim_c BufWritePost <buffer>

imap -- ->
imap '' ->
