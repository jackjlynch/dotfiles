let mapleader=" "
let maplocalleader="\\"

set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

:augroup unfold
:  autocmd!
:  autocmd Syntax * normal zR
:augroup END

:augroup nvr
:  autocmd!
:  autocmd FileType gitcommit set bufhidden=delete
:augroup END

set colorcolumn=140
set tw=140

" 24bit color settings
set termguicolors
"" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"


call plug#begin('~/.vim/plugged')

" Plug '~/.fzf'

Plug 'scrooloose/nerdcommenter'
Plug 'wesQ3/vim-windowswap'
Plug 'raimondi/delimitmate'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'lifepillar/vim-solarized8'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
" Plug 'w0rp/ale'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'morhetz/gruvbox'
Plug 'chrisbra/Colorizer'
Plug 'easymotion/vim-easymotion'
Plug 'direnv/direnv.vim'
" Plug 'tpope/vim-eunuch'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

syntax enable
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox
let g:colorizer_auto_filetype='css,html'
let g:indentLine_setConceal = 0

" indentation and tabs to two spaces:
filetype plugin indent on
" tabs displayed as two spaces
set tabstop=2
" > inserts two spaces
set shiftwidth=2
" two spaces on tab press instead of tab
set expandtab
" indent correctly
set softtabstop=2

set scrolloff=8
set sidescrolloff=15
set sidescroll=1

set fileformat=unix
set fileformats=unix,dos
set nofixendofline
" set noendofline binary

" don't kill windowless buffers
set hidden

" tsx syntax highlighting
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

" let g:ale_linters = { 'javascript': ['eslint', 'tsserver'] }
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_insert_leave = 1

" hi tsxTagName ctermfg=1 guifg=#d30102

" hi tsxCloseString ctermfg=6 guifg=#2aa198
" hi tsxCloseTag ctermfg=6 guifg=#2aa198
" hi tsxAttributeBraces ctermfg=6 guifg=#2aa198
" hi tsxEqual ctermfg=6 guifg=#2aa198

" hi tsxAttrib ctermfg=2 cterm=italic gui=italic guifg=#859900

set hlsearch

set timeoutlen=250

inoremap jk <Esc>
tnoremap jk <c-\><c-n>

nnoremap <f1> <nop>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-o> :Files<CR>
" nnoremap <tab> :Buffers<CR>
" nnoremap <CR> :Marks<CR>
nnoremap <leader>gb :Gbranch<cr>
nnoremap <leader>n :noh<cr>
nmap <leader>r <Plug>(coc-rename)
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>f <Plug>(coc-fix-current)
imap <expr><cr> pumvisible()
      \ ? "\<C-y>"
      \ : "\<C-g>u<Plug>delimitMateCR"

nnoremap <leader>cq :cclose<cr>
nnoremap <leader>ch :ColorHighlight<cr>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <leader><c-u> <esc>viwUea
nnoremap <leader><c-u> viwUe
nnoremap oo o<esc>k
nnoremap OO O<esc>j
nnoremap <leader>p :set paste!<cr>

cnoreabbrev Ack Ack!

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" coc.nvim settings
set cmdheight=2
set updatetime=300
set shortmess+=c

" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsSnippetsDir=$HOME . '/.vim/UltiSnips'
let g:UltiSnipsSnippetDirectories=[$HOME . '/.vim/UltiSnips']
let g:UltiSnipsListSnippets='<c-l>'


" airline options
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1

nnoremap <C-e> :NERDTreeToggle<CR>

let g:NERDSpaceDelims = 1

set nowrap
set showmatch
set matchtime=0
set shiftround
set ignorecase
set smartcase
set foldmethod=syntax

let g:fzf_layout = { 'down': '~20%' }

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

if filereadable($HOME . '/chromium/src/tools/vim/filetypes.vim')
  source ${HOME}/chromium/src/tools/vim/filetypes.vim
endif

set completeopt-=preview

if executable('ag')
  let g:ackprg = 'ag -f --vimgrep'
endif

" from https://vi.stackexchange.com/questions/5921/easiest-way-to-switch-git-branches
function! s:changebranch(branch) 
    execute 'Git checkout' . a:branch
    call feedkeys("i")
endfunction

command! -bang Gbranch call fzf#run({
            \ 'source': 'git branch -a --no-color | grep -v "^\* " ', 
            \ 'sink': function('s:changebranch')
						\ })

function! s:getClipboard()
  let rawText = system('powershell.exe -command get-clipboard')
  return split(rawText, '\n')
endfunction

" let g:clipboard = {
      " \   'name': 'wslClipboard',
      " \   'copy': {
      " \     '+': 'clip.exe',
      " \     '*': 'clip.exe',
      " \   },
      " \   'paste': {
      " \     '+': {->s:getClipboard()},
      " \     '*': {->s:getClipboard()},
      " \   },
      " \   'cache_enabled': 1,
      " \ }

set backupdir=~/.vim/backup/
set directory=~/.vim/backup/