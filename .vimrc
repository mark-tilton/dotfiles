" Enable syntax highlighting
syntax enable

" Show line numbers
set number

" Remove need to press shift when typing :
map ; :

call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'toranb/tmux-navigator'
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

" When a python file is opened, map F5, in the current buffer, to execute :w
" and !python %. shellescape is used to escape potential special characters.
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
