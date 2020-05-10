syntax match plaintexInputFile display
    \ /\v\\input.+/
	\ contains=initexFileIOCommand,@NoSpell,Macro,plaintexControlSequence,initexLogicGroup,initexMacroCommand

syntax match plaintexCommentControlSequence display
    \ '\\[a-zA-Z@]\+\(\>\|\d\)'
    \ contained 
    \ containedin=initexComment,plaintexComment
    \ contains=@NoSpell

syntax match plaintexCommentHexnum display
	\ '"\%(\x\+\)\(\W\|$\)\@='
	\ contained
	\ containedin=initexComment,plaintexComment
	\ contains=@NoSpell

highlight def link plaintexCommentControlSequence Comment	
highlight def link plaintexCommentHexnum Comment	

syntax match plaintexArg display /\v#\d/
hi link plaintexArg Special

syntax clear plaintexMath
syntax match plaintexMath display /\v\${1,2}/
" syntax region  plaintexMath matchgroup=plaintexMath
" 	\ contains=@plaintexMath,@NoSpell keepend
" 	\ start=/\V\\(/ skip='\\\\\|\\\$' end=/\V\\)/
" syntax region  plaintexMath matchgroup=plaintexMath
" 	\ contains=@plaintexMath,@NoSpell keepend
" 	\ start=/\V\\[/ skip='\\\\\|\\\$' end=/\V\\]/

syntax region plaintexURL
	\ start='\\url\(<\|{\)'
	\ end='\(>\|}\)'
	\ contains=@NoSpell,plaintexControlSequence

" order matters here
syntax match plaintexHexnum display contains=@NoSpell
	\ '"\%(\x\+\)\(\W\|$\)\@='
syntax match plaintexNumbers display contains=@NoSpell
      \ '[+-]\=\s*\%(\d\+\%([.,]\d*\)\=\|[.,]\d\+\)\s*'
syntax match plaintexDim display contains=plaintexNumbers,@NoSpell
      \ '[+-]\=\s*\%(\d\+\%([.,]\d*\)\=\|[.,]\d\+\)\s*\%(true\)\=\s*\%(p[tc]\|in\|bp\|c[mc]\|m[mu]\|dd\|sp\|e[mx]\)\>'
syntax match plaintexFill contains=plaintexNumbers,@NoSpell display
      \ '\s*\d\+\s*fil\{1,3}\>'

hi link plaintexHexnum plaintexNumbers
hi link plaintexFill plaintexNumbers
hi link plaintexDim plaintexNumbers

" syntax match plaintexFill display contains=@NoSpell /\v\d\+fil{1,3}l\@!/

syntax match plaintexMathCommand display contains=@NoSpell 
 \ '\\\%([!*,;>{}|_^]\|\%([aA]rrowvert\|[bB]ig\%(g[lmr]\=\|r\)\=\|\%(border\|p\)\=matrix\|displaylines\|\%(down\|up\)bracefill\|eqalign\%(no\)\|leqalignno\|[lr]moustache\|mathpalette\|root\|s[bp]\|skew\|sqrt\)\>\)'
syntax match plaintexMathBoxCommand display contains=@NoSpell 
 \ '\\\%([hv]\=phantom\|mathstrut\|smash\)\>'
syntax match plaintexMathCharacterCommand display contains=@NoSpell 
 \ '\\\%(b\|bar\|breve\|check\|d\=dots\=\|grave\|hat\|[lv]dots\|tilde\|vec\|wide\%(hat\|tilde\)\)\>'
syntax match plaintexMathDelimiter display contains=@NoSpell 
 \ '\\\%(brace\%(vert\)\=\|brack\|cases\|choose\|[lr]\%(angle\|brace\|brack\|ceil\|floor\|group\)\|over\%(brace\|\%(left\|right\)arrow\)\|underbrace\)\>'
syntax match plaintexMathFontsCommand display contains=@NoSpell 
 \ '\\\%(\%(bf\|it\|sl\|tt\)fam\|cal\|mit\)\>'
syntax match plaintexMathLetter display contains=@NoSpell 
 \ '\\\%(aleph\|alpha\|beta\|chi\|[dD]elta\|ell\|epsilon\|eta\|[gG]amma\|[ij]math\|iota\|kappa\|[lL]ambda\|[mn]u\|[oO]mega\|[pP][hs]\=i\|rho\|[sS]igma\|tau\|[tT]heta\|[uU]psilon\|var\%(epsilon\|ph\=i\|rho\|sigma\|theta\)\|[xX]i\|zeta\)\>'
syntax match plaintexMathSymbol display contains=@NoSpell 
 \ '\\\%(angle\|backslash\|bot\|clubsuit\|emptyset\|epsilon\|exists\|flat\|forall\|hbar\|heartsuit\|Im\|infty\|int\|lnot\|nabla\|natural\|neg\|pmod\|prime\|Re\|sharp\|smallint\|spadesuit\|surd\|top\|triangle\%(left\|right\)\=\|vdash\|wp\)\>'
syntax match plaintexMathFunction display contains=@NoSpell 
 \ '\\\%(arc\%(cos\|sin\|tan\)\|arg\|\%(cos\|sin\|tan\)h\=\|coth\=\|csc\|de[gt]\|dim\|exp\|gcd\|hom\|inf\|ker\|lo\=g\|lim\%(inf\|sup\)\=\|ln\|max\|min\|Pr\|sec\|sup\)\>'
syntax match plaintexMathOperator display contains=@NoSpell 
 \ '\\\%(amalg\|ast\|big\%(c[au]p\|circ\|o\%(dot\|plus\|times\|sqcup\)\|triangle\%(down\|up\)\|uplus\|vee\|wedge\|bmod\|bullet\)\|c[au]p\|cdot[ps]\=\|circ\|coprod\|d\=dagger\|diamond\%(suit\)\=\|div\|land\|lor\|mp\|o\%(dot\|int\|minus\|plus\|slash\|times\)pm\|prod\|setminus\|sqc[au]p\|sqsu[bp]seteq\|star\|su[bp]set\%(eq\)\=\|sum\|times\|uplus\|vee\|wedge\|wr\)\>'
syntax match plaintexMathPunctuation display contains=@NoSpell 
 \ '\\\%(colon\)\>'
syntax match plaintexMathRelation display contains=@NoSpell 
 \ '\\\%(approx\|asymp\|bowtie\|buildrel\|cong\|dashv\|doteq\|[dD]ownarrow\|equiv\|frown\|geq\=\|gets\|gg\|hook\%(left\|right\)arrow\|iff\|in\|leq\=\|[lL]eftarrow\|\%(left\|right\)harpoon\%(down\|up\)\|[lL]eftrightarrow\|ll\|[lL]ongleftrightarrow\|longmapsto\|[lL]ongrightarrow\|mapsto\|mid\|models\|[ns][ew]arrow\|neq\=\|ni\|not\%(in\)\=\|owns\|parallel\|perp\|prec\%(eq\)\=\|propto\|[rR]ightarrow\|rightleftharpoons\|sim\%(eq\)\=\|smile\|succ\%(eq\)\=\|to\|[uU]parrow\|[uU]pdownarrow\|[vV]ert\)\>'

hi MatchParen cterm=bold ctermbg=none ctermfg=Magenta
hi def link plaintexNumbers initexNumber
