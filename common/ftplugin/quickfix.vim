"autocmd BufReadPost quickfix nnoremap <buffer> <CR> :.cc<CR>:ccl<CR>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> :.cc<CR><C-W>w

autocmd BufReadPost quickfix exec "au WinLeave <buffer> cclose"
autocmd BufReadPost quickfix nnoremap <silent> <buffer> q :ccl<CR>
autocmd BufReadPost quickfix nnoremap <silent> <buffer> gt <C-W><CR><C-W>T
autocmd BufReadPost quickfix nnoremap <silent> <buffer> gT <C-W><CR><C-W>TgT<C-W><C-W>
autocmd BufReadPost quickfix nnoremap <silent> <buffer> o <CR>
autocmd BufReadPost quickfix nnoremap <silent> <buffer> go <CR><C-W><C-W>
autocmd BufReadPost quickfix nnoremap <silent> <buffer> h <C-W><CR><C-W>K
autocmd BufReadPost quickfix nnoremap <silent> <buffer> H <C-W><CR><C-W>K<C-W>b
autocmd BufReadPost quickfix nnoremap <silent> <buffer> v <C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t
autocmd BufReadPost quickfix nnoremap <silent> <buffer> gv <C-W><CR><C-W>H<C-W>b<C-W>J