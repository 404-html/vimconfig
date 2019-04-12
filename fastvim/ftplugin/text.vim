setlocal nofoldenable foldcolumn=0

" meetings ה:
" reading ק:
" email ס:
" address ן:
" home address פ:

" conf.vim includes this
" $BULK/s*/g*/c*/v*/vim/ftplugin/conf.vim

" Text only or will affect python

"autocmd Syntax * call TextSyntax()
autocmd VimEnter,BufWinEnter,BufEnter * silent! call TextSyntax()


inoreab i I
inoreab im I'm
inoreab iam I'm
"inoreab itis it's
"" type itisC<Space> " doesn't work
"inoreab Itis It's
inoreab id I'd
inoreab il I'll
inoreab god God
inoreab shane Shane
inoreab xuan Xuan
inoreab yolanda Yolanda
inoreab abigail Abigail
inoremap X Xuan~

" use folding if we can
if has ('folding')
  set foldenable
  set foldmethod=marker
  set foldmarker={{{,}}}
  "set foldcolumn=0
  " need this set to something > 0 for the mouse to work
  set foldcolumn=2
  set foldminlines=10
  silent! windo set foldlevel=100 " this has to be made silent because the command window is also a vim bufer and it will cause an error message
endif
