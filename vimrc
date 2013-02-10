" Backup and tmp dir
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" CD to dir of current file
set autochdir
" Use 256 colors
set t_Co=256
" Automatically re-read file when changed
set autoread
" Share Windows clipboard
set clipboard+=unnamed

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,.git\*,.hg\*,.svn\*
" Configure backspace so it acts as it should
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Highlight search results
set hlsearch
" Ignore case when searching
set ignorecase
" Incremental search
set incsearch
" Smart case search
set smartcase

" Highlights matching brackets
set showmatch

set linespace=0
" Show trailing whitespace
set listchars=trail:·
set mouse=a " Enable mouse
set nocopyindent " Follow previous indent level


" Add a margin to the left
set foldcolumn=2

" Auto-create closing brackets
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" Add tab-specific settings at the end of the file
set modeline
set modelines=5

" Enable syntax highlight
syntax enable

try
	let g:solarized_termcolors=256
	set background=dark
	
	if has ("gui_running")
		colorscheme solarized
	else
		colorscheme desert
	endif
catch
endtry

set encoding=utf8
set ffs=unix,dos,mac

set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" linebreak on 150 characters
set lbr
set tw=150

" Auto indent
set ai
" Smart indent
set si
" Wrap lines
set wrap

" Show line numbers
set number

filetype on
augroup vimrc_filetype
	" <F6> to Compile
	" <F7> ro Run
	autocmd FileType    c               map <F6> :w<CR>:!echo -- Compiling %; gcc -o %< %<CR>
	autocmd FileType    cpp             map <F6> :w<CR>:!echo -- Compiling %; g++ -o %< %<CR>
	autocmd FileType    c,cpp           map <F7> <S-F7><CR>
	autocmd FileType    c,cpp           map <S-F7> :!echo -- Running %<; ./%<

	" Compiling Java
	autocmd FileType    java            map <F6> :w<CR>:!echo -- Compiling %; javac %<CR>
	autocmd FileType    java            map <F7> <S-F7><CR>
	autocmd FileType    java            map <S-F7> :!echo -- Running %<; java %<

	" Syntax-indenting for programming...
	"autocmd FileType    c,cpp,java,php  set foldmethod=syntax
	"autocmd FileType    c,cpp,java,php  inoremap {<CR>  {<CR>}<Esc>O
	
	" Java specific
	autocmd FileType    java            abbr syso System.out.println("");

	" C++ specific
	autocmd FileType    cpp             abbr syso cout << "" << endl;
augroup end

" Return to last edit position when opening files
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\	 exe "normal! g`\"" |
	\ endif

" Append modeline after last line in buffer.
" " Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" " files.
function! AppendModeline()
	let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
	
	call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
