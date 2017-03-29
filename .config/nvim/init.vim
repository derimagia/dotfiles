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

" Clear out search on <C-L>
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Keys
map <C-n> :NERDTreeToggle<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Mapping - Clipboard
set clipboard+=unnamedplus
vmap <C-c> "+yi

" Mapping - Remove up/down/left/right
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Plugins
call plug#begin("$XDG_DATA_HOME/nvim/plugged")
    Plug 'ctrlpvim/ctrlp.vim'
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

colorscheme OceanicNext

" CtrlP Settings
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|idea|DS_Store)$'

" NerdTree
let g:NERDTreeShowHidden = 1

" AirLine
let g:airline_powerline_fonts = 1
