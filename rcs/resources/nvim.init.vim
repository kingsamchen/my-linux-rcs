set number              " Show the line numbers on the left side.
set showmatch           " Show matching brackets.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.

set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
    set scrolloff=3     " Show next 3 lines while scrolling.
endif

if !&sidescrolloff
    set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif

set nostartofline       " Do not jump to first character with page commands.

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'

Plug 'technetos/vim-quantum'

" Initialize plugin system
call plug#end()

let g:airline_theme='quantum'

let g:molokai_original = 1
let g:quantum_black = 1

set background=dark
set termguicolors

colorscheme quantum


