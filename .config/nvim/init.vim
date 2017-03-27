" Plugins -------------------------------------------------------------

if has('nvim') || has('gui_vimr')
    call plug#begin("$XDG_DATA_HOME/nvim/plugged")
    Plug 'bling/vim-airline'
    Plug 'airblade/vim-gitgutter'
    Plug 'mhartington/oceanic-next'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'
    Plug 'junegunn/fzf.vim'
    Plug 'othree/yajs.vim'
    Plug 'tpope/vim-sleuth'
    call plug#end()

    let g:airline_powerline_fonts = 1

    colorscheme OceanicNext
else
    if empty(glob("$XDG_CACHE_HOME/vim"))
      execute 'silent !mkdir -p $XDG_CACHE_HOME/vim'
    endif

    set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
    set ttymouse=xterm2
endif

if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

set t_Co=256
set background=dark
set encoding=utf8

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
set hlsearch            " highlighted search results
set incsearch
set noerrorbells        " no error nells
set visualbell          " visual bell
set backspace=indent,eol,start
set complete-=i
set nrformats-=octal
set ttimeout
set ttimeoutlen=100
set laststatus=2
set ruler
set wildmenu

if has('autocmd')
    " enable filetype detection, filetype-specific indenting, filetype-specific plugins
    filetype plugin indent on
endif

if !&scrolloff
    set scrolloff=1
endif
if !&sidescrolloff
    set sidescrolloff=5
endif
set display+=lastline

if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j " Delete comment character when joining commented lines
endif

set sessionoptions-=options

" mouse with iterm2
set ttyfast
set mouse=a

" Keys
" map <C-n> :NERDTreeToggle<CR>
command! -nargs=1 Locate call fzf#run(
      \ {'source': 'locate <q-args>', 'sink': 'e', 'options': '-m'})

" Mapping - Clipboard
set clipboard=unnamedplus
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" Mapping - Remove up/down/left/right
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" FZF
set rtp+=/usr/local/opt/fzf/

" matchit
runtime! macros/matchit.vim

" vimpager
if exists('g:vimpager')
    filetype on
    syntax on
    set nonumber
    set norelativenumber
endif
