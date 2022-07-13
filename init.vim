set secure
set number
set expandtab
set shiftwidth=2
set tabstop=2
set exrc
set secure
set hidden
set nobackup
set nowritebackup
set updatetime=300
set timeoutlen=300
set signcolumn=yes
set mouse=a

" Custom leader commands
let mapleader="\<Space>"
nnoremap <silent> <leader>q :lclose<bar>bp<bar>bd #<CR>
map <leader>r :e %:h<cr>
map <leader>b :OpenBookmark 

" Filetype alias
autocmd! BufRead,BufNewFile *.cconf     setfiletype python
autocmd! BufRead,BufNewFile TARGETS     setfiletype python
autocmd! BufRead,BufNewFile BUCK        setfiletype python

call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'

" File explorer 
Plug 'scrooloose/nerdtree'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='deus'

" Allow using c-hjkl to move between vim splits and tmux windows
Plug 'toranb/tmux-navigator'

" Navigation
Plug 'tpope/vim-repeat'
Plug 'ggandor/leap.nvim'
Plug 'pechorin/any-jump.vim'

" Commenting
Plug 'preservim/nerdcommenter'

" Theme
Plug 'morhetz/gruvbox'

" Git
Plug 'tpope/vim-fugitive'

" Ctrl-p file search
Plug 'ctrlpvim/ctrlp.vim'

" Language servers
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-pyright',
    \ 'coc-css',
    \ 'coc-json',
    \ 'coc-clangd',
    \ 'coc-rust-analyzer',
    \ 'coc-svelte'
    \ ]

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'
Plug 'herringtondarkholme/yats.vim'
Plug 'leafOfTree/vim-svelte-plugin'

" Diff directories
Plug 'will133/vim-dirdiff'

call plug#end()

" Setup for nerdcommenter
filetype plugin on
let g:NERDCreateDefaultMappings = 0
nmap <leader>c <Plug>NERDCommenterToggle
vmap <leader>c <Plug>NERDCommenterToggle

" Setup ctrl-p to use ag
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Setup plugins
lua require('leap').set_default_keymaps()

" === Setup file associations ===
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" === Setup theme ===
" Enable true color support for nvim
let $NVIM_TUT_ENABLE_TRUE_COLOR = 1
let g:gruvbox_italic = 1 " Enable italics in gruvbox
set termguicolors " Enable true color support in gruvbox
colorscheme gruvbox " Enable gruvbox
hi Normal guibg=NONE ctermbg=NONE

" === Setup autocomplete ===
" Automatically close preview split
autocmd InsertLeave,CompleteDone * if pumvisible() == 1 | pclose | endif

" Navigate autocomplete with <tab>
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>l  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>
