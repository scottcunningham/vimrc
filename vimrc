"
" .vimrc
"
" A collection of cruft, accumulated over time from friends.
"

" Basics
set nocompatible
set timeoutlen=1000
set ttimeoutlen=0
set number
set cursorline
set laststatus=2
syntax enable

" Vundle
" - git clone https://github.com/gmarik/vundle ~/.vim/bundle
" - :PluginUpdate
" - Compile YouCompleteMe
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'Valloric/YouCompleteMe'
Plugin 'klen/python-mode'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'

" Airline for status display line

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set guifont=Inconsolata\ for\ Powerline

" And tmux
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'y'    : ['%R', '%a', '%Y'],
      \'z'    : '#H'}

" Display-related things
set ruler
set background=dark
set hidden           " Make certain buffers hidden
set pastetoggle=<F2> " Bind pastetoggle to F2
set showmode         " Show what mode you're in
set title
set novisualbell
set noerrorbells

" Colours 
set t_Co=256         " 256 colours
set laststatus=2     " Always show the statusline

"Highlight spaces, tabs, etc
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Indentation etc.
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

" Line-related things
set number           " Show line number

" Searching
set showmatch        " Hilights matching searched
set ignorecase       " Searches are case insensitive...
set smartcase        " ... unless they contain at least one capital letter

" Encodings
set encoding=utf-8   " Necessary to show Unicode glyphs
set nomodeline       " Disable reading the first and last few lines of each file for ex commands, for security reasons

" Tabs, spaces and history
set textwidth=80     " Sets width of text per line, 0 for line wrapping
set cc=80
set expandtab
set ts=4
set sw=4
set softtabstop=4
set shiftround
set t_vb=
set history=1000
set tabpagemax=50

" Tags
set tags=./tags;/    " Search the source tree for tags
let Tlist_Ctags_Cmd = "/usr/bin/ctags" " For taglist
let Tlist_WinWidth = 50 " For Taglist
let g:tagbar_autofocus = 1 " go to tagbar window automatically

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

autocmd Filetype pl set syntax=prolog

"Turn on mouse integration
set mouse=a
set ttyfast

"`vsplit` to the right, `split` new windows below the current one
set splitright
set splitbelow

"Powerline settings
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts=1

" Spelling
au BufNewFile,BufRead,BufEnter *.txt setlocal spell spelllang=en_gb

"Show the current mode and command in the status bar
set showmode
set showcmd
set backspace=indent,eol,start

" Settings for screen
if match($TERM, "screen")!=-1
    set term=xterm
endif
