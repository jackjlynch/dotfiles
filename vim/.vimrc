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

Plug '~/.fzf'

Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdcommenter'
Plug 'wesQ3/vim-windowswap'
Plug 'raimondi/delimitmate'
Plug 'Valloric/YouCompleteMe'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'lifepillar/vim-solarized8'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'morhetz/gruvbox'
Plug 'chrisbra/Colorizer'
Plug 'easymotion/vim-easymotion'
Plug 'direnv/direnv.vim'

call plug#end()

syntax enable
set background=dark
" let g:solarized_use16=1
" colorscheme solarized8
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

" don't kill windowless buffers
set hidden

" tsx syntax highlighting
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

let g:ale_linters = { 'javascript': ['eslint', 'tsserver'] }
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

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
nnoremap <tab> :Buffers<CR>
nnoremap <CR> :Marks<CR>
nnoremap <leader>gb :Gbranch<cr>
nnoremap <leader>n :noh<cr>
nnoremap <leader>r :YcmCompleter RefactorRename 
nnoremap <leader>gd :leftabove vertical YcmCompleter GoTo<cr>
nnoremap <leader>gr :YcmCompleter GoToReferences<cr>
nnoremap <leader>f :YcmCompleter FixIt<cr>

inoremap <leader><c-u> <esc>viwUea
nnoremap <leader><c-u> viwUe
nnoremap oo o<esc>k
nnoremap OO O<esc>j

cnoreabbrev Ack Ack!

" YouCompleteMe  + delimitMate backspace workaround
" https://github.com/Valloric/YouCompleteMe/issues/2696
imap <silent> <BS> <C-R>=YcmOnDeleteChar()<CR><Plug>delimitMateBS

function! YcmOnDeleteChar()
    if pumvisible()
          return "\<C-y>"
            endif
              return "" 
            endfunction

" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsSnippetsDir=$HOME . '/.vim/UltiSnips'
let g:UltiSnipsSnippetDirectories=[$HOME . '/.vim/UltiSnips']
let g:UltiSnipsListSnippets='<c-l>'


" airline options
" let g:airline_theme='solarized'
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

let g:ycm_goto_buffer_command='split-or-existing-window'
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
" if $AT_WORK
  " let g:ycm_extra_conf_globlist=[$HOME . '/chromium/.ycm_extra_conf.py']
  " source ${HOME}/chromium/src/tools/vim/filetypes.vim
  " source ${HOME}/chromium/src/tools/vim/ninja-build.vim
  " source ${HOME}/chromium/src/tools/vim/clang-format.vim
" endif
set completeopt-=preview

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
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

set backupdir=~/.vim/backup/
set directory=~/.vim/backup/
