" This actually means that when I open the 'emacs' wrapper script, it shows me the incorrect highlighting.
" It is, however, better than breaking filetype detection for the actual emacs config file, as it is located, in a git repository.
au BufRead,BufNewFile emacs,.spacemacs,.closhrc   set filetype=lisp
