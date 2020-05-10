let s:thisfilefolder = expand("<sfile>:p:h")
let s:luatexmakefile = s:thisfilefolder . "/luatexmakefile"
let s:lualatexmakefile = s:thisfilefolder . "/lualatexmakefile"
let s:latexmakefile = s:thisfilefolder . "/latexmakefile"
let s:plaintexmakefile = s:thisfilefolder . "/plaintexmakefile"

" As long as the files are kept together, everything should be fine.

function! LuaTeXMake()
	write
	let l:target = expand("%:r") . ".pdf"
	if &ft ==? "tex"
		exe "Make -C '" . expand("%:p:h") . "' -f '" . s:lualatexmakefile . "' " . l:target
	elseif &ft ==? "plaintex"
			exe "Make -C '" . expand("%:p:h") . "' -f '" . s:luatexmakefile . "' " . l:target
	endif
endfunction

function! TeXMake()
	write
	let l:target = expand("%:r") . ".pdf"
	if &ft ==? "tex"
		exe "Make -C '" . expand("%:p:h") . "' -f '" . s:latexmakefile . "' " . l:target
	elseif &ft ==? "plaintex"
		exe "Make -C '" . expand("%:p:h") . "' -f '" . s:plaintexmakefile . "' " . l:target
	elseif &ft ==? "markdown"
		exe "!pandoc '" . expand("%") . "' -o " . l:target
	endif
	" I don't know why, but using an uppercase letter for M is better.
endfunction
