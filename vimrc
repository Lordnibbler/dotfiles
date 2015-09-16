" Included in every vim config
set nocompatible
set hidden

set ruler "Bottom bar
set number "Numbers
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
syntax on

" Spaces and Indention
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set backspace=indent,eol,start
let &listchars="tab:\ \ ,trail:\x2e" " Highlight trailing whitespace
set list

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Backup/swap here
set backupdir=~/.vim/swap/
set directory=~/.vim/swap/
" But don't
set nobackup
set nowritebackup
set noswapfile

" OSx Clipboard happiness
set clipboard=unnamed

" Using the mouse is cool
set mouse=a

" Splelcheck
set spell spelllang=en_us
set nospell

" Vim WordProc
func! WordProcessorMode()
  setlocal formatoptions=t1
  setlocal noexpandtab
  setlocal textwidth=80
  setlocal smartindent
  setlocal spell spelllang=en_us
  setlocal complete+=s
  setlocal wrap
  setlocal linebreak
  map j gj
  map k gk
  nnoremap <buffer> <leader>p gqip
endfunc
com! WP call WordProcessorMode()

" Mappings
let mapleader = ";" " Leader

" Generic non-plugin specific mappings
" source ~/.vim/mappings.vim

" Show line highlight on Normal
set cursorline
au InsertLeave * set cursorline
au InsertEnter * set nocursorline


" The colors
set background=dark
let g:solarized_termcolors=256

" FT Plugins, and syntax
filetype plugin indent on
