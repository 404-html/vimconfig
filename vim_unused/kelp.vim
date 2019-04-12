" Vim kelp
"
" Written by D. Harris, 2 Sep 2007
" 
" *** Public domain boilerplate here ***
"
" Kelp requires 7.0 - load plugin only once 
if v:version < 700 || exists('loaded_kelp')
	finish
endif
let loaded_kelp = 1

" kelp plugin requires kelp
if !executable( 'kelp' )
	echo 'Kelp plugin says "kelp not installed."'
	finish
endif

function s:runkelp( kelpargs )
	let s:kelpcmd = '!kelp'
	for s:kelparg in split(a:kelpargs)
		if s:kelparg == '_'
			let s:kelparg .= expand("%:t")
		endif
		let s:kelpcmd .= ' ' . s:kelparg
	endfor
	execute s:kelpcmd
endfunction

" Command :Kelp
command! -nargs=* Kelp call s:runkelp(<q-args>)
