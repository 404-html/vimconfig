" Vim syntax file
" Language: Grep Output
" Maintainer: Shane Mulligan
" Latest Revision: 5 June 2014

if exists("b:current_syntax")
  finish
endif

syntax case ignore
syntax match GrepFile /^[^:]*/
      \ nextgroup=GrepSeparator
syntax match GrepSeparator /:/
      \ nextgroup=GrepLineNr
syntax match GrepLineNr /^\d\+\ze:/
      \ nextgroup=GrepPattern
highlight default link GrepFile SpecialKey
highlight default link GrepSeparator NonText
highlight default link GrepLineNr LineNR