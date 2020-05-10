" This function will not work if a:type == 'i' and there are no lines between
" \begin and \end. The environment is not recognized if the cursor in on the
" \end marker. Although I think it's possible to fix this, I don't want to
" right now.

" The functions should be able to handle a count.
function s:select_environment (type)
	normal $
	call searchpair(
		\ '\\begin{', '',
		\ '\\end{',
		\ 'Wbc')
	if a:type == 'i'
		let l:start_line = line('.')
		normal j
	endif
	normal V
	call searchpair(
		\ '\\begin{', '',
		\ '\\end{',
		\ 'Wc')
	if a:type == 'i'
		normal k
	endif
	normal $
endfunction

xnoremap <buffer> <silent> ae :<c-u>call <sid>select_environment('a')<cr>
onoremap <buffer> <silent> ae :<c-u>call <sid>select_environment('a')<cr>

xnoremap <buffer> <silent> ie :<c-u>call <sid>select_environment('i')<cr>
onoremap <buffer> <silent> ie :<c-u>call <sid>select_environment('i')<cr>

nnoremap <buffer> <silent> ]e :<C-U>call search('\\begin', 'W')<CR>
nnoremap <buffer> <silent> ]E :<C-U>call search('\\end', 'W')<CR>
nnoremap <buffer> <silent> [e :<C-U>call search('\\begin', 'Wb')<CR>
nnoremap <buffer> <silent> [E :<C-U>call search('\\end', 'Wb')<CR>
