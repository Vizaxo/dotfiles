" settings
set nocompatible " This must be first, because it changes other options as a side effect.
"set backspace=indent,eol,start " allow backspacing over everything in insert mode
set nobackup		" do not keep a backup file, they're annoying
set noundofile		" no not keep an undo file (undo changes after closing)
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set incsearch		" do incremental searching
set number		" } show hybrid line numbers
set relativenumber	" }
set textwidth=80	" set a red bar at 81 chars
set colorcolumn=+1
set laststatus=2	"always show status line
let g:netrw_dirhistmax = 0	"disable netrw history
set tildeop		" tilde works with motions
set list listchars=tab:·\ ,nbsp:·	"show trailing whitespace
set ttimeoutlen=0	" no delay exiting command or visual modes
set showcmd		" show partial commands in corner
set autoindent		" automatic content-sensitive indent
"set t_Co=256		" force 256-colour terminal
set splitright
set scrolloff=8

execute pathogen#infect()
let g:slime_target = "tmux"

filetype plugin indent on 
" intelligent indenting in functions, comments etc.

" NoPlugins talk:
set path+=**
set wildmenu
let g:netrw_banner=0
let g:netrw_liststyle=3

let mapleader = " "

noremap <leader>/ :nohl<CR>
noremap <leader>h <C-t>
noremap <leader>l <C-]>

" remappings
" use s to do pslit options
noremap s <C-w>
" use H/L for beginning/end of line
noremap H ^
noremap ^ H
noremap L $
noremap $ L
inoremap jk <ESC>
"inoremap <ESC> <Nop>

" use J/K for paragraph movement
noremap J }
noremap K {

" navigate longlines like normal lines
"noremap j gj
"noremap k gk

" use r for reverting undo. cl still does what r does, but is more composable
noremap r <C-r>

" x joins lines, X splits lines
" Splitting clears  trailing whitespace from previous line and doesn't
" interfere with the search history
noremap x J
noremap X i<CR><ESC>k$:s/\s\+$//e<CR>j^
	\:call histdel("search", -1)<CR>:let @/ = histget("search", -1)<CR>

noremap <silent> <leader>/ :noh<cr>
noremap <silent> <leader>s :set spell!<cr>

" Use cmdwin for all commands
noremap ; q:i
noremap : ;
noremap / q/i
noremap ? q?i
set cmdwinheight=1
autocmd CmdwinEnter * nnoremap jk :set cmdwinheight=1<CR>:q<CR>
autocmd CmdwinEnter * nnoremap <ESC> :set cmdwinheight=1<CR>:q<CR>
autocmd CmdwinEnter * nnoremap s mQ:set cmdwinheight=5<CR>:q<CR>q:'Q
"autocmd CmdwinLeave * set cmdwinheight=1
autocmd CmdwinLeave * nnoremap s <C-w>
"autocmd CmdwinEnter * nnoremap ; i
autocmd CmdwinLeave * nunmap jk
autocmd CmdwinLeave * nunmap <ESC>
noremap <CR> o<ESC>
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd CmdWinLeave * noremap <CR> o<ESC>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
"endif

" go to last known curser position in a file
"autocmd BufReadPost *
"\ if line("'\"") >= 1 && line("'\"") <= line("$") |
"\   exe "normal! g`\"" |
"\ endif

" Folding
set foldmethod=syntax
set foldnestmax=1
nnoremap zo mZjzo2kzo`Z
nnoremap zc jzc2kzcj

" colourscheme
colo darkblue2

" tab-completion
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>
inoremap <c-c> <Tab>

autocmd FileType text set tw=0
autocmd FileType lambda inoremap \ λ
