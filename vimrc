set background=dark
syntax enable
set tabstop=4
set shiftwidth=4
set number
set showcmd
set wildmenu
set termguicolors
set cindent
set cursorline
set splitbelow
set splitright
set backspace=indent,eol,start
let delimitMate_expand_cr = 1

" Clipboard shortcuts
map <C-c> "+y<CR>
map <C-v> "+p<CR>
map <C-x> dd
map <C-z> u
map <C-e> :vertical resize 100<CR>

let mapleader = "`"
" Use ` to save and exit all buffers
noremap <leader> :wall<CR>:qall!<CR>
" Use <F1> to force exit all buffers
noremap <F1> :qall!<CR>

" Indentguides using listchars
:set listchars=tab:\│\
:set list
:hi SpecialKey ctermfg=236 guifg=grey19

" Legacy coderunner
map <F8> :w<CR>:!. ~/.vim/coderunner.sh %:e %:r<CR>

" Press F5 to run code
map <F5> :w<CR>:call RunCode()<CR><C-w><C-w><CR>

function RunCode()
	if expand('%:e') == "c"
		:call term_sendkeys(2, "clear && gcc ")
		:call term_sendkeys(2, expand('%'))
		:call term_sendkeys(2, " -lm && ./a.out && echo")
	elseif expand('%:e') == "cpp"
		:call term_sendkeys(2, "clear && g++ ")
		:call term_sendkeys(2, expand('%'))
		:call term_sendkeys(2, " -lm && ./a.out && echo")
	elseif expand('%:e') == "java"
		:call term_sendkeys(2, "clear && javac ")
		:call term_sendkeys(2, expand('%'))
		:call term_sendkeys(2, " && java ")
		:call term_sendkeys(2, expand('%:r'))
		:call term_sendkeys(2, " && echo")
	elseif expand('%:e') == "py"
		:call term_sendkeys(2, "clear && python ")
		:call term_sendkeys(2, expand('%'))
	endif
endfunction

colorscheme d4rk

if expand('%:e') == "c"
	vert term ++cols=40 sh
elseif expand('%:e') == "cpp"
	vert term ++cols=40 sh
elseif expand('%:e') == "java"
	vert term ++cols=40 sh
elseif expand('%:e') == "py"
	vert term ++cols=40 sh
endif

" Autocomplete parentheses
let g:xptemplate_brace_complete = '([{'

" Templates for C, C++ and bash scripts
if has("autocmd")
	augroup templates
		autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh | :2
		autocmd BufNewFile *.c 0r ~/.vim/templates/skeleton.c | :7
		autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp | :9
		autocmd BufNewFile *.java 0r ~/.vim/templates/skeleton.java | s/FILENAME/\=expand("%:t:r")
		autocmd BufNewFile *.java :3
	augroup END
endif

" Vim-Plug
call plug#begin('~/.vim/plugged')
Plug 'Raimondi/delimitMate'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Default Airline to molokai
let g:airline_theme='molokai'

" Darken line numbers
highlight LineNr ctermfg=242

" Hide end-of-buffer tildes
highlight EndOfBuffer ctermfg=black ctermbg=black guifg=black guibg=black

" Highlight current line numbers
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline
highlight CursorLine cterm=NONE

" Colorize C operators
syntax match mySpecialSymbols "+\|-\|\*\|?\|:\|<\|>\|&\||\|!\|\~\|%\|="
highlight mySpecialSymbols ctermfg=208

" Better intellisense suggestions colorscheme
highlight Pmenu ctermbg=238 guibg=#444444

" Enable cursorline
set cursorline
hi CursorLine guibg=#161616

" Recolor cursor line numbers
hi CursorLineNr guifg=white ctermfg=15 cterm=bold
hi SpecialKey ctermfg=236 guifg=grey19

" Better looking vertical split lines
set encoding=utf8
set fillchars=vert:│
highlight VertSplit cterm=NONE ctermfg=White ctermbg=NONE

" Use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Start Vim in Insert mode
startinsert
