" markdown filetype file
" Got sick of consecutive apostophes making highlighting.
"au BufRead,BufNewFile *.conf,notes.txt,links.txt,help.txt   set filetype=conf
au BufRead,BufNewFile *.conf   set filetype=conf
