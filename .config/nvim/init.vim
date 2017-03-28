" Autoload doesn't load for vimpager right now so load it.
if !exists('plug#begin')
    source $XDG_DATA_HOME/nvim/site/autoload/plug.vim
endif

set t_Co=256
set background=dark
set encoding=utf8
set number              " line numbers
set showmatch           " show matching brackets
set scrolloff=5
set mouse=a

" Keys
" map <C-n> :NERDTreeToggle<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

command! -nargs=1 Locate call fzf#run(
      \ {'source': 'locate <q-args>', 'sink': 'e', 'options': '-m'})

" Mapping - Clipboard
set clipboard+=unnamedplus

" Mapping - Remove up/down/left/right
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" FZF
set rtp+=/usr/local/opt/fzf/

" Plugins
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

let g:NERDTreeShowHidden=1
let g:airline_powerline_fonts = 1
colorscheme OceanicNext
