" Based on darkblue

set bg=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
let colors_name = "darkblue2"

"hi Normal	"ctermfg=gray 		"ctermbg=black
hi ErrorMsg	ctermfg=black 		ctermbg=lightblue
hi Visual	ctermfg=white 		ctermbg=black cterm=reverse
hi VisualNOS	ctermfg=lightblue 	cterm=reverse,underline
hi Todo		ctermfg=red		ctermbg=darkblue
hi Search	ctermfg=black		ctermbg=yellow cterm=underline term=underline
hi IncSearch	ctermfg=darkblue 	ctermbg=gray

hi SpecialKey	ctermfg=darkcyan
hi Directory	ctermfg=cyan
hi Title	ctermfg=magenta 	cterm=bold
hi WarningMsg	ctermfg=red
hi WildMenu	ctermfg=yellow 		ctermbg=black 	cterm=none term=none
hi ModeMsg	ctermfg=lightblue
hi MoreMsg	ctermfg=darkgreen	ctermfg=darkgreen
hi Question	ctermfg=green 		cterm=none
hi NonText	ctermfg=darkblue

hi StatusLine	ctermfg=black 		ctermbg=green term=none cterm=none
hi StatusLineNC	ctermfg=black 		ctermbg=gray term=none cterm=none
hi VertSplit	ctermfg=black 		ctermbg=grey term=none cterm=none

hi Folded	ctermfg=darkgrey 	ctermbg=black cterm=bold term=bold
hi FoldColumn	ctermfg=grey 		ctermbg=black cterm=bold term=bold
hi LineNr	ctermfg=lightgray 	cterm=none

hi DiffAdd	ctermbg=darkblue term=none cterm=none
hi DiffChange	ctermbg=magenta cterm=none
hi DiffDelete	ctermfg=blue ctermbg=cyan
hi DiffText	cterm=bold ctermbg=red

hi Cursor	ctermfg=black ctermbg=yellow
hi lCursor	ctermfg=black ctermbg=white

hi Comment	ctermfg=green
hi Constant	ctermfg=magenta cterm=none
hi Special	ctermfg=brown cterm=none
hi Identifier	ctermfg=cyan cterm=none
hi Statement	ctermfg=yellow cterm=none
hi PreProc	ctermfg=magenta cterm=none
hi type		ctermfg=blue cterm=none
hi Underlined	cterm=underline term=underline
