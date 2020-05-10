" returns the name of the current environment
" or an empty string if not in an environment
" moves cursor to beginning of open tag
function s:search_env_name(...)
	let l:current_pos = getpos('.')
	" [bufname, line, col, virtual]
	while 1
		let l:end_line = search('\\end','Wc')
		if l:end_line == 0
			" no more environments in file
			let l:begin_line = [0,0]
			break
		endif

		let l:env_name = matchstr(getline('.'),
			\ '\%' . col('.') . 'c\\end\zs\w\+')

		" back up
		normal ge

		" find matching start
		" [line, col]
		let l:begin_line = searchpairpos(
			\ '\\' . l:env_name, '',
			\ '\\end' . l:env_name,
			\ 'Wcbn')

		" move past \end
		normal el

		" check line and position
		if ( l:begin_line[0] <= l:current_pos[1] && l:begin_line[1] <= l:current_pos[2])
			break
		endif
	endwhile

	if (l:begin_line[0] == 0)
		call setpos('.', l:current_pos)
		return ""
	else
		" move to open tag of current environment
		call setpos('.', [
			\ l:current_pos[0],
			\ l:begin_line[0],
			\ l:begin_line[1],
			\ l:current_pos[3]
			\ ])
		return l:env_name
	endif
endfunction

" highlight is incorrect when environment is empty
" or contains no lines.
function s:select_plain_env(type)

	let l:win_view = winsaveview()

	let l:env_name = s:search_env_name()
	if l:env_name == ''
		call winrestview(l:win_view)
		return
	endif

	if a:type == 'i'
		" cursor is on backslash of open
		" move to first non-open char
		normal 2w
		" move past optional arguments
		if getline('.')[col('.')-1] == '['
			normal w
			call searchpair('\[','','\]','Wc')
			normal w
		endif
		" TODO: skip mandatory arguments, too
	else
		normal w
	endif

	normal v

	call searchpair(
		\ '\\' . l:env_name, '',
		\ '\\end' . l:env_name,
		\ 'Wc')
	if a:type == 'i'
		" cursor is on backslash of close
		" move to previous character
		normal ge
	else
		normal eoho
	endif
endfunction

" use search modes?
" initial search until you encounter begin BELOW cursor position
" 	- can only happen if there are no more environments below
" 	  or if you're in the last set of nested environments
" then search until you either
" 	- encounter begin BELOW previous
" 	- encounter begin ABOVE cursor position
" 	- encounter end of file
" deeply nested environments would be a killer
function s:search_env_start(flags)

	let l:win_view = winsaveview()
	let l:current_pos = getpos('.')
	" [bufname, line, col, virtual]

	let l:end_line = search('\\end', 'Wc')

	let l:prev_begin = [l:current_pos[1],l:current_pos[2]]
	while 1

		let l:end_line = search('\\end','Wc')
		if l:end_line == 0
			" no more environments in file
			let l:begin_line = [0,0]
			break
		endif

		let l:env_name = matchstr(getline('.'),
			\ '\%' . col('.') . 'c\\end\zs\w\+')

		" back up
		normal ge

		" find matching start
		" [line, col]
		let l:begin_line = searchpairpos(
			\ '\\' . l:env_name, '',
			\ '\\end' . l:env_name,
			\ 'Wcbn')

		" move past \end
		normal el

	endwhile

endfunction

xnoremap <buffer> <silent> ae :<c-u>call <sid>select_plain_env('a')<cr>
onoremap <buffer> <silent> ae :<c-u>call <sid>select_plain_env('a')<cr>

xnoremap <buffer> <silent> ie :<c-u>call <sid>select_plain_env('i')<cr>
onoremap <buffer> <silent> ie :<c-u>call <sid>select_plain_env('i')<cr>

" nnoremap <buffer> <silent> ]e :<C-U>call <sid>search_env_start('')<CR>
nnoremap <buffer> <silent> ]E :<C-U>call search('\\end', 'W')<CR>
" nnoremap <buffer> <silent> [e :<C-U>call <sid>search_env_start('b')<CR>
nnoremap <buffer> <silent> [E :<C-U>call search('\\end', 'Wb')<CR>

" select inside and around dollar signs
onoremap <silent> i$ :<C-U>normal! T$vt$<CR>
onoremap <silent> a$ :<c-u>normal! F$vf$<cr>
vnoremap i$ T$ot$
vnoremap a$ F$of$
