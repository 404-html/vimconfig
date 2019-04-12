"autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
"au FileType python au BufWritePre *.py :%s/\s*$//g
"au BufWritePre *.py :%s/\s*$//g

" do not remove whitespace on save
"au BufWritePre *.py let save_cursor = getpos('.') | %s/\s*$//|call setpos('.', save_cursor)

"disable folding
"au BufWritePre *.py let save_cursor = getpos('.') | %s/\s*$//|call setpos('.', save_cursor)|set nofoldenable foldcolumn=0

au BufRead *.py let python_highlight_all=1
au BufRead *.py let python_highlight_space_errors=1
au BufRead *.py let python_fold=1

au BufRead,BufNewFile SConscript	set filetype=python

