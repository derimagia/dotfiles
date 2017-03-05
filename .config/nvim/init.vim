" Plugins -------------------------------------------------------------

if has('nvim')
    call plug#begin("$XDG_DATA_HOME/nvim/plugged")
    Plug 'mhartington/oceanic-next'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'
    Plug 'scrooloose/nerdtree'
    Plug 'bling/vim-airline'
    Plug 'junegunn/fzf.vim'
    Plug 'othree/yajs.vim'
    call plug#end()

    colorscheme OceanicNext
else
    if empty(glob("$XDG_CACHE_HOME/vim"))
      execute '!mkdir -p $XDG_CACHE_HOME/vim'
    endif

    set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
    set ttymouse=xterm2
endif

syntax enable
set t_Co=256
set background=dark
set encoding=utf8

set clipboard=unnamed
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

set nobackup            " don't create pointless backup files; Use VCS instead
set cursorline          " highlight the current line
set autoread            " watch or file changes
set number              " line numbers
set showcmd             " selection metadata
set showmode            " show INSERT, VISUAL, etc. mode
set showmatch           " show matching brackets
set autoindent smartindent  " auto/smart indent
set smarttab            " better backspace and tab functionality
set scrolloff=5         " show at least 5 lines above/below
filetype on             " enable filetype detection
filetype indent on      " enable filetype-specific indenting
filetype plugin on      " enable filetype-specific plugins

" FZF
set rtp+=/usr/local/opt/fzf/

" bells
set noerrorbells
set visualbell

" search
set hlsearch            " highlighted search results
set showmatch           " show matching bracket

" mouse with iterm2
set ttyfast
set mouse=a

" Keys
map <C-n> :NERDTreeToggle<CR>
command! -nargs=1 Locate call fzf#run(
      \ {'source': 'locate <q-args>', 'sink': 'e', 'options': '-m'})

" Add FZF"
set rtp+=/usr/local/opt/fzf

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" vimpager
if exists('g:vimpager')
    filetype on
    syntax on
    set nonumber
    set norelativenumber
endif
