" Enable configuration file of each directory.
" Version: 0.2.0
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

if exists('g:loaded_localrc')
  finish
endif
let g:loaded_localrc = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:localrc_filename')
  let g:localrc_filename = '.local.vimrc'
endif

if !exists('g:localrc_filetype')
  let g:localrc_filetype = '/^\.local\..*\<%s\>.*\.vimrc$'
endif


" sped up vim by caching if localrc is loaded
augroup plugin-localrc
  autocmd!
  autocmd VimEnter * nested
  \                  if ! exists('b:loaded_bufenter_localrc')
  \                | let b:loaded_bufenter_localrc = 1
  \                | if argc() == 0
  \                |   call localrc#load(g:localrc_filename)
  \                | endif
  \                | endif
  autocmd BufNewFile,BufReadPost * nested
  \                  if ! exists('b:loaded_bufread_localrc')
  \                | let b:loaded_bufread_localrc = 1
  \ | call localrc#load(g:localrc_filename)
  \                | endif
  autocmd FileType * nested
  \                  if ! exists('b:loaded_bufft_localrc')
  \                | let b:loaded_bufft_localrc = 1
  \ | call localrc#load(
  \     map(type(g:localrc_filetype) == type([]) ? copy(g:localrc_filetype)
  \                                              : [g:localrc_filetype],
  \         'printf(v:val, expand("<amatch>"))'))
  \                | endif
augroup END


let &cpo = s:save_cpo
unlet s:save_cpo
