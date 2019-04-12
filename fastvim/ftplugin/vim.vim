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

"TagbarOpen
"TagbarSetFoldlevel! 1
