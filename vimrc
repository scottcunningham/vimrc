"
" .vimrc
"

"  _               _          
" | |__   __ _ ___(_) ___ ___ 
" | '_ \ / _` / __| |/ __/ __|
" | |_) | (_| \__ \ | (__\__ \
" |_.__/ \__,_|___/_|\___|___/
"                             
set nocompatible
set timeoutlen=1000
set ttimeoutlen=0
set number
set cursorline
set laststatus=2
syntax enable
set colorcolumn=120

" Ignore cruft files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.tmp/*,*/.sass-cache/*,*/node_modules/*,*.keep,*.DS_Store,*/.git/*

" No perl, assume prolog
" Hopefully I'll never have to write either again
autocmd Filetype pl set syntax=prolog

" `vsplit` to the right, `split` new windows below the current one
set splitright
set splitbelow

" Spell-checker
au BufNewFile,BufRead,BufEnter *.txt setlocal spell spelllang=en_GB

"Show the current mode and command in the status bar
set showmode
set showcmd
set backspace=indent,eol,start

" In screen, we pretend that our $TERM is xterm so that things 
" display correctly
if match($TERM, "screen")!=-1
    set term=xterm
endif

set background=dark

"      _ _           _             
"   __| (_)___ _ __ | | __ _ _   _ 
"  / _` | / __| '_ \| |/ _` | | | |
" | (_| | \__ \ |_) | | (_| | |_| |
"  \__,_|_|___/ .__/|_|\__,_|\__, |
"             |_|            |___/ 
" 
"

" Misc. display-related things
set hidden           " Make certain buffers hidden
set showmode         " Show what mode you're in
set title
set novisualbell
set noerrorbells
set hlsearch         " Highlights search results

" Colours 
set t_Co=256         " 256 colours
set laststatus=2     " Always show the statusline

"Highlight spaces, tabs, etc
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
" Line-related things
set number           " Show line number

" Searching
set showmatch        " Hilights matching searched
set ignorecase       " Searches are case insensitive...
set smartcase        " ... unless they contain at least one capital letter

" Encodings
set encoding=utf-8   " Necessary to show Unicode glyphs
set nomodeline       " Disable reading the first and last few lines of each file for ex commands, for security reasons

"  _              _     _           _ _                 
" | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___ 
" | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
" |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
" |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
"           |___/                             |___/     
"           

"
" Misc keybindings
"

" Disable F1 going into annoying help mode
nmap <F1> <nop>
" w!! will write as sudo
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>
" Bind f2 to pastetoggle
nnoremap <F2> :set invpaste paste?<CR>
" Rebinding supertab to <F3>
let g:SuperTabMappingForward = '<F3>'
" swaps between header and source
map <F4> :A<CR>
" opens a definition in a new tab
map <F5> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" opens a definition in a vspilt
map <F6> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>)
" set tagbartoggle
nmap <F7> :TagbarToggle<CR>
" go to definition
map <F8> <C-]> 
" maps NERDTree to F10
map <silent> <F10> :NERDTreeToggle<CR>

"   __                            _   _   _             
"  / _| ___  _ __ _ __ ___   __ _| |_| |_(_)_ __   __ _ 
" | |_ / _ \| '__| '_ ` _ \ / _` | __| __| | '_ \ / _` |
" |  _| (_) | |  | | | | | | (_| | |_| |_| | | | | (_| |
" |_|  \___/|_|  |_| |_| |_|\__,_|\__|\__|_|_| |_|\__, |
"                                                 |___/ 

"
" Tabs, spaces and history
"
set textwidth=120     " Sets width of text per line, 0 for line wrapping
set cc=120
set expandtab
set ts=4
set sw=4
set softtabstop=4
set shiftround
set t_vb=
set history=1000
set tabpagemax=50

" Indentation and code-related display options. 
set ai               " Set autoindent
set smartindent      " Use intelligent indentation
set wrap             " Set wrapping
set linebreak        " For some reason, wiki says this should be set when trying to disasble linebreak
set nolist           " List disables linebreak
set wrapmargin=0     " Stop inserting line break on wrap
set formatoptions+=1 " Stop wrapping
filetype plugin on
filetype plugin indent on
filetype indent on   " Makes indentation different per file, good with html
filetype on


"                _      
"   ___ ___   __| | ___ 
"  / __/ _ \ / _` |/ _ \
" | (_| (_) | (_| |  __/
"  \___\___/ \__,_|\___|
"                       

" Tags
set tags=./tags;/    " Search the source tree for tags
let Tlist_Ctags_Cmd = "/usr/bin/ctags" " For taglist
let Tlist_WinWidth = 50 " For Taglist
let g:tagbar_autofocus = 1 " go to tagbar window automatically

" Turn off code folding
set nofoldenable
set foldlevelstart=10

"         _             _           
"   _ __ | |_   _  __ _(_)_ __  ___ 
"  | '_ \| | | | |/ _` | | '_ \/ __|
"  | |_) | | |_| | (_| | | | | \__ \
"  | .__/|_|\__,_|\__, |_|_| |_|___/
"  |_|            |___/             
"  

"
" Vundle-related settings
"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'Valloric/YouCompleteMe'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'Raimondi/delimitMate'
Plugin 'jeroenbourgois/vim-actionscript'

"
" Airline settings 
"

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#left_alt_sep = '|'
set guifont=Inconsolata\ for\ Powerline

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'y'    : ['%R', '%a', '%Y'],
      \'z'    : '#H'}

"
" Flake8 options
"

" Auto-run on file write
autocmd BufWritePost *.py call Flake8()
" Longer line length
let g:flake8_max_line_length=120
" Remap it to F1
autocmd FileType python map <buffer> <F1> :call Flake8()<CR>

"
" ctrlp settings
"

" Use ag-thesilversearcher for ctrl-p search backend.
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

