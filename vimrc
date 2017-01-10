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
" gtfo
set mouse=""

" Ignore cruft files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.tmp/*,*/.sass-cache/*,*/node_modules/*,*.keep,*.DS_Store,*/.git/*

" `vsplit` to the right, `split` new windows below the current one
set splitright
set splitbelow

" Spell-checker on txt files
au BufNewFile,BufRead,BufEnter *.txt setlocal spell spelllang=en_GB


" In screen, we pretend that our $TERM is xterm so that things
" display correctly
if match($TERM, "screen")!=-1
    set term=xterm
endif

let mapleader=","


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
set showmode         " Show active mode
set showcmd          " Show active command
set backspace=indent,eol,start
set title
set novisualbell
set noerrorbells
set hlsearch         " Highlights search results
set background=dark

" Colours
set t_Co=256         " 256 colours
set laststatus=2     " Always show the statusline

if has('gui_running')
    colorscheme codeschool
endif

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

" Gui options: hide all of the bars, text only
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

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
" Bind f3 to numtoggle
nnoremap <F3> :set invnumber number?<CR>
" maps NERDTree to F10
map <silent> <F10> :NERDTreeToggle<CR>
" CtrlPLine is ctrlp but for the current file
map <C-o> :CtrlPLine<CR>
" Virtual line wrapping
nnoremap j gj
nnoremap k gk
" No arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"   __                            _   _   _
"  / _| ___  _ __ _ __ ___   __ _| |_| |_(_)_ __   __ _
" | |_ / _ \| '__| '_ ` _ \ / _` | __| __| | '_ \ / _` |
" |  _| (_) | |  | | | | | | (_| | |_| |_| | | | | (_| |
" |_|  \___/|_|  |_| |_| |_|\__,_|\__|\__|_|_| |_|\__, |
"                                                 |___/

"
" Tabs, spaces and history
"
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
set linebreak        " For some reason, wiki says this should be set when trying to disable linebreak
set nolist           " List disables linebreak
set wrapmargin=0     " Stop inserting line break on wrap
set formatoptions+=1 " Stop wrapping
filetype plugin on
filetype plugin indent on
filetype indent on   " Makes indentation different per file, good with html
filetype on

au BufRead,BufNewFile *.eyaml setfiletype yaml


"                _
"   ___ ___   __| | ___
"  / __/ _ \ / _` |/ _ \
" | (_| (_) | (_| |  __/
"  \___\___/ \__,_|\___|
"

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

Plugin 'godlygeek/tabular'
Plugin 'gmarik/vundle'
Plugin 'Valloric/YouCompleteMe'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'Raimondi/delimitMate'
Plugin 'jeroenbourgois/vim-actionscript'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'vim-scripts/Conque-Shell'
"Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'chase/vim-ansible-yaml'
Plugin 'rodjek/vim-puppet'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-scripts/PreserveNoEOL'
Plugin 'markcornick/vim-terraform'
Plugin 'tpope/vim-markdown'
Plugin 'mhinz/vim-startify'
Plugin 'mhinz/vim-signify'
Plugin 'pangloss/vim-javascript'
" Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Shougo/vimshell.vim'
Plugin 'Shougo/vimproc.vim'
" Plugin 'fatih/vim-hclfmt'
Plugin 'tommcdo/vim-fubitive'
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-speeddating'
Plugin 'pearofducks/ansible-vim'

" Markdown filetypes
au! BufRead,BufNewFile *.markdown set filetype=mkd
au! BufRead,BufNewFile *.md       set filetype=mkd
"
" Airline settings
"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#left_alt_sep = '|'
set guifont=Inconsolata\ for\ Powerline\ 11
"let g:syntastic_python_checkers=["flake8"]
let g:PreserveNoEOL = 1

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
" Remap it to F1
autocmd FileType python map <buffer> <F1> :call Flake8()<CR>
" Markdown filetypes
au! BufRead,BufNewFile *.markdown set filetype=mkd
au! BufRead,BufNewFile *.md       set filetype=mkd

" Automagically set ansible filetype in all ansible repos
autocmd BufRead,BufNewFile ~/src/ansible/ens-ansible/playbooks/*.yml set ft=ansible
autocmd BufRead,BufNewFile ~/src/ansible/ens-ansible/playbooks/*.yaml set ft=ansible
autocmd BufRead,BufNewFile ~/src/ansible/*/*/*.yml set ft=ansible
autocmd BufRead,BufNewFile ~/src/ansible/*/*/*.yaml set ft=ansible

" _
"| |_ ___ _ __ _ __ ___
"| __/ _ \ '__| '_ ` _ \
"| ||  __/ |  | | | | | |
" \__\___|_|  |_| |_| |_|
"

" Spawn a neovim zsh terminal with f4
nnoremap <F4> :e term://zsh <CR>
if has('neovim')
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
endif
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

abbreviate xPpProfile class { profiles::fixme (<CR><TAB>String fix  => hiera('profiles::fixme::fix', ''),<CR>){<CR><TAB># code<CR>}

"
" ctrlp settings
"

" Use ag-thesilversearcher for ctrl-p search backend.
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let g:syntastic_ruby_checkers          = ['rubocop']
let g:syntastic_ruby_rubocop_exec      = 'bundle exec rubocop'


" stolen
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/

" Fode Colding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF
"
"let python_highlight_all=1

" osx clipboard omg
"set clipboard=unnamed

" stupid RVM breaks syntastic
" https://rvm.io/integration/vim
" https://github.com/skwp/dotfiles/issues/590
set shell=/bin/sh

" go away rbenv :/
"" let g:syntastic_ruby_mri_exec = "/Users/Scott/.rbenv/shims/ruby"
