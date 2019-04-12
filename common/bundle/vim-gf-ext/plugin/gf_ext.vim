" gf-ext.vim - Extend "gf" to open files with external programs
" Author: Daniel P. Wright (http://dpwright.com)

if exists("g:loaded_gf_ext") || v:version < 700 || &cp
  finish
endif
let g:loaded_gf_ext = 1

command! -nargs=+ -complete=command GoWhich call GoWhich(<q-args>)

" This file is deprecated. see 'open'

"noremap <silent> gf :<C-U>call gf_ext#run_handler_for_file(expand("<cfile>"),v:count)<cr>
"xnoremap <silent> gf "zy:<C-U>call gf_ext#run_handler_for_file("<C-R>z",v:count)<cr>
"noremap <silent> ge :normal! gf<cr>
"xnoremap <silent> ge "zy:e <C-R>z<cr>


" in vimrc
" MapM OpenFileInTmux(expand("<cfile>")) g e


" I want to be able to open files quickly without opening tmux. reserve
" gf for the default behavior
"noremap gf :<C-U>call gf_ext#GoFileTmux(expand("<cfile>"))<cr>
"xnoremap gf "zy:<C-U>call gf_ext#GoFileTmux("<C-R>z")<cr>

"noremap <silent> ge :<C-U>silent! call gf_ext#GoFileTmux(expand("<cfile>"))<cr>
"xnoremap <silent> ge "zy:<C-U>silent!call gf_ext#GoFileTmux("<C-R>z")<cr>
noremap <silent> gh :<C-U>silent! call gf_ext#GoUrlTmux(expand("<cfile>"))<cr>
xnoremap <silent> gh "zy:<C-U>silent! call gf_ext#GoUrlTmux("<C-R>z")<cr>
" map <silent> gf ge
" xmap <silent> gf ge
"noremap <silent> gw :<C-U>silent! call gf_ext#GoWhichTmuxRifle(expand("<cWORD>"))<cr>
"xnoremap <silent> gw "zy:<C-U>silent! call gf_ext#GoWhichTmuxRifle("<C-R>z")<cr>
"noremap <silent> gw :<C-U>call gf_ext#GoWhichTmuxRifle(expand("<cWORD>"))<cr>
"xnoremap <silent> gw "zy:<C-U>call gf_ext#GoWhichTmuxRifle("<C-R>z")<cr>
"noremap <silent> gW :<C-U>silent! call gf_ext#GoWhich(expand("<cWORD>"))<cr>
"xnoremap <silent> gW "zy:<C-U>silent! call gf_ext#GoWhich("<C-R>z")<cr>
noremap <silent> gc :<C-U>silent! call gf_ext#GoLocateTmuxRifle(expand("<cfile>"))<cr>
xnoremap <silent> gc "zy:<C-U>silent! call gf_ext#GoLocateTmuxRifle("<C-R>z")<cr>
noremap <silent> gC :<C-U>silent! call gf_ext#GoLocate(expand("<cfile>"))<cr>
xnoremap <silent> gC "zy:<C-U>silent! call gf_ext#GoLocate("<C-R>z")<cr>
noremap <silent> gt :<C-U>silent! call gf_ext#GoTmuxRifle(expand("<cfile>"))<cr>
xnoremap <silent> gt "zy:<C-U>silent! call gf_ext#GoTmuxRifle("<C-R>z")<cr>
noremap <silent> gu :<C-U>call gf_ext#GoSearchCroogle(expand(getline('.')),v:count1)<cr>
xnoremap <silent> gu "zy:<C-U>call gf_ext#GoSearchCroogle("<C-R>z",v:count1)<cr>
noremap <silent> gs :<C-U>call gf_ext#GoSearchCode(expand(getline('.')),v:count1)<cr>
xnoremap <silent> gs "zy:<C-U>call gf_ext#GoSearchCode("<C-R>z",v:count1)<cr>
noremap <silent> go :<C-U>call gf_ext#GoSearchStackOverflow(expand(getline('.')))<cr>
xnoremap <silent> go "zy:<C-U>call gf_ext#GoSearchStackOverflow("<C-R>z")<cr>
" vim:set et sw=2:
au BufEnter * let g:gfpath=getcwd()
