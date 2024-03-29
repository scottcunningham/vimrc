" vim:foldmethod=marker:foldlevel=0
"
" .vimrc
"
" Re-worked to match suggestions by dougblack https://dougblack.io/words/a-good-vimrc.html
"

" General settings {{{
set nocompatible    " Get rid of vi compatibility
set grepprg=ag\ --nogroup\ --nocolor  " Use ag for :grep
set history=100     " Remember the last 100 commands
set modeline        " Enable modelines
set modelines=1     " Check 1 line for modeline config
au BufNewFile,BufRead,BufEnter *.txt setlocal spell spelllang=en_US  " Spell-checking, US only for now (?)
"}}}

" Colours {{{
syntax enable       " Enable syntax highlighting
set t_Co=256        " Use the full 256 colours
" }}}

" Spaces & tabs {{{
set tabstop=4       " Number of visual spaces per tab
set softtabstop=4   " Number of spaces in tab when editing
set expandtab       " When I press tab, insert spaces
set shiftwidth=4    " Number of columns text is indented with << and >>
set shiftround      " Round to the nearest `shiftwidth` when doing << and >> operations (not just 4 spaces)
set autoindent      " Set autoindent
set smartindent     " Use intelligent indentation
" }}}

" UI / Display {{{
set number                 " Show line numbers
set showcmd                " Show active command
set cursorline             " Highlight current line
set wildmenu               " Visual autocomplete for command menu
filetype indent on         " Load filetype-specific indent files
filetype plugin indent on  " Sets indentation based on plugins
filetype plugin on         " Enable loading plugin files for specific file types
set lazyredraw             " Only redraw when necessary
set showmatch              " Highlights matching braces
set showmode               " Show active mode
set title                  " Automatically set screen title
set novisualbell           " Don't flash the screen on a BEL
set noerrorbells           " Don't BEL on error
set t_vb=                  " Set visual bell to empty so that we don't bell
set laststatus=2           " Always show the statusline
set list                   " 'list' highlight spaces, tabs, etc with special characters
set encoding=utf-8         " Necessary to show Unicode glyphs
" Configure the special chars for list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set splitright             " vsplit splits to the right of the current pane
set splitbelow             " split splits below the current pane
set wrap                   " Set wrapping
set wrapmargin=0           " Stop inserting line break on wrap
" }}}

" Searching {{{
set incsearch       " Search as characters are entered (incremental search)
set hlsearch        " Highlight matches when searching
set ignorecase      " Searches are case insensitive...
set smartcase       " ... unless they contain at least one capital letter
" }}}

" Folding {{{
set foldenable         " Enable folding (change to nofoldenable to disable)
set foldlevelstart=10  " Open most folds by default
set foldnestmax=10     " Max 10 nested folds
nnoremap <space> za    " Open/close folds with space
set foldmethod=indent  " Do folding based on indentation level (works well for Python etc)
" }}}

" Movement {{{
" Virtual line wrapping
nnoremap j gj
nnoremap k gk
" No arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" No mouse
set mouse=""
" }}}

" Misc keybindings {{{
nmap <F1> <nop>                          " Disable F1 going into annoying help mode
nnoremap <F2> :set invpaste paste?<CR>   " Toggle paste with F2
nnoremap <F3> :set invnumber number?<CR> " Toggle numbers with F3
map <silent> <F10> :NERDTreeToggle<CR>   " Toggle NERDTree with F10
" }}}

" Options for specific filetypes{{{
" Python
autocmd BufWritePost *.py execute ':execute "!black %" | e'
autocmd BufWritePost *.py call Flake8() " Auto-run flake8 when we write a Python file
nnoremap <C-S-c> :Black<CR>
" Go
autocmd BufWritePre *.go :GoFmt  " Auto-format go on save
autocmd BufWritePre *.go :GoImports " Auto-format go imports on save
autocmd BufWritePost *.go execute ':GoDiagnostics! all'
" Markdown
au! BufRead,BufNewFile *.markdown set filetype=markdown " Associate *.markdown with markdown syntax
au! BufRead,BufNewFile *.md       set filetype=markdown " Associate *.md with markdown syntax
" }}}

" Plugins {{{
filetype off   " Required for loading Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'               " Let Vundle manage Vundle

Plugin 'ntpeters/vim-better-whitespace'     " Highlight trailing whitespace
Plugin 'nvie/vim-flake8'                    " Python: style checking
Plugin 'raimondi/delimitMate'               " Auto-complete matching quotes, brackets, etc
Plugin 'scrooloose/nerdtree'                " Graphical file manager
Plugin 'tpope/vim-fugitive'                 " Git wrapper
Plugin 'tpope/vim-sensible'                 " Universally good defaults
Plugin 'vim-airline/vim-airline'            " Fancy status bar
Plugin 'vim-airline/vim-airline-themes'     " Fancy theme for fancy status bar
Plugin 'vim-scripts/PreserveNoEOL'          " Omit the final newline of a file if it wasn't present when we opened it
Plugin 'christoomey/vim-tmux-navigator'     " vim+tmux
Plugin 'ambv/black'                         " Reformat Python
Plugin 'darrikonn/vim-gofmt'                " Go format
Plugin 'junegunn/fzf'                       " Fuzzy find stuff
Plugin 'dense-analysis/ale'                 " Completion, formatting, etc
Plugin 'junegunn/rainbow_parentheses.vim'   " Rainbow brackets
Plugin 'ray-x/go.nvim'
call vundle#end()
filetype plugin indent on

" We don't have up-to-date vim/nvim, ignore it
let g:go_version_warning = 0

set rtp+=~/.fzf

" }}}

" Plugin configuration {{{

" Airline
let g:airline_powerline_fonts = 1                   " Use patched powerline fonts
let g:airline#extensions#tabline#enabled = 1        " Display all buffers when only one tab open
let g:airline#extensions#tabline#left_sep = ' '     " Separators for tabs
let g:airline#extensions#tabline#left_alt_sep = '|' " Separators for tabs
let g:airline_theme='powerlineish'                  " Powerline-type theme for Airline
" Ctrl-P
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " Use ag for ctrl-p search backend
map <leader>/ :CtrlPLine<CR>                          " Use CtrlP to search the current file with ,/
let ctrlp_switch_buffer=0                             " Always open files in new buffer
let g:ctrlp_working_path=0                            " Tell CtrlP to respect when we change directories


" Rainbow parens
autocmd FileType * RainbowParentheses
let g:rainbow#blacklist = [30, 40]

" Ale
let g:ale_linters = {'python': ['autopep8', 'flake8', 'pyre', 'pyls', 'pylint'], 'go': ['gofmt', 'golangserver']}
nmap <C-d> :ALEGoToDefinition<CR>

" }}}

" NeoVim terminal settings {{{
nnoremap <F4> :e term://zsh <CR> " Spawn a neovim zsh terminal with f4
if has('neovim')
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
endif
" }}}
