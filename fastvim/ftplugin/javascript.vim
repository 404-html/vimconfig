setlocal nofoldenable foldcolumn=0 number
setlocal nolist
"setlocal nofoldenable foldcolumn=0 relativenumber

" Change these so that they use Ack instead of CtrlP
" Also, make it so current file results are listed first.
" Also, make it easy to optionally search only javascript and json
" files.
" finds where a variable is changed
"nmap <buffer> ( vit"zy;let @z="\\<<C-r>z\\>\\s*[\*/+-]\\?=[^=]"<CR>;CtrlPLine<CR><C-r><C-\>rz

" finds where a variable is defined
"nmap <buffer> <CR> vit"zy;let @z="\\(var\\s+\\<<C-r>z\\>\\\|\\<<C-r>z\\>\\s*=\\s*function(\\\|function\\s*\\<<C-r>z\\>\\)"<CR>;CtrlPLine<CR><C-r><C-\>rz<CR><C-c>
