" Enable syntax highlighting
syntax enable

" Show line numbers
set number

call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'

" File explorer 
Plug 'scrooloose/nerdtree'

" Language specific comments
Plug 'scrooloose/nerdcomment'

" Status bar
Plug 'vim-airline/vim-airline'

" Allow using c-hjkl to move between vim splits and tmux windows
Plug 'toranb/tmux-navigator'

" Navigate files with c-p
Plug 'ctrlpvim/ctrlp.vim'

" Theme
Plug 'morhetz/gruvbox'

" Autocomplete
Plug 'Shougo/deoplete.nvim', {'do': 'UpdateRemotePlugins'}
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

call plug#end()

" When a python file is opened, map F5, in the current buffer, to execute :w
" and !python %. shellescape is used to escape potential special characters.
autocmd FileType python map <buffer> <F5> :w<CR>:exec "!tmux run-shell -t 1 \"python .\""<CR>

" === Setup theme ===
" Enable true color support for nvim
let $NVIM_TUT_ENABLE_TRUE_COLOR = 1

" Enable italics in gruvbox
let g:gruvbox_italic = 1

" Enable true color support in gruvbox
set termguicolors

" Enable gruvbox
autocmd vimenter * colorscheme gruvbox

" === Setup autocomplete ===
" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1

" Automatically close preview split
autocmd InsertLeave,CompleteDone * if pumvisible() == 1 | pclose | endif

" Navigate autocomplete with <tab>
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Disable the autocomplete portion of the davidhalter jedi plugin
let g:jedi#completeions_enabled = 0

" Open definitions in a split on the right
let g:jedi#use_splits_not_buffers = "right"
