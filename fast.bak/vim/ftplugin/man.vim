setlocal nofoldenable foldcolumn=0 hlsearch


set startofline
" this is used in conjuction with the vimpager wrapper.
" this makes sure that after the vimpager wrapper determines the man
" page's desirable width, vim is not prevented from drawing stubborn
" characters.
call system('resize')
