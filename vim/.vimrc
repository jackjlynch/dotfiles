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

" Persistent Undo
set undofile
set undodir=~/.vim/undo/

call plug#begin('~/.vim/plugged')

" Core
Plug 'scrooloose/nerdcommenter'
Plug 'wesQ3/vim-windowswap'
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'easymotion/vim-easymotion'
Plug 'direnv/direnv.vim'
Plug 'tpope/vim-sleuth'

" Search & Navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mhinz/vim-grepper'
Plug 'romainl/vim-cool'

" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" UI
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'morhetz/gruvbox'

" LSP & Completion
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'windwp/nvim-autopairs'

call plug#end()

lua require('config')

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

" don't kill windowless buffers
set hidden

" tsx syntax highlighting
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

set hlsearch

set timeoutlen=250

inoremap jk <Esc>
tnoremap jk <c-\><c-n>

" workaround to keep escape sequence out of terminal
tnoremap <S-Space> <Space>

nnoremap <f1> <nop>

" Telescope Mappings
nnoremap <C-p> <cmd>Telescope git_files<cr>
nnoremap <C-o> <cmd>Telescope find_files<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>f <cmd>Telescope live_grep<cr>

nnoremap <leader>n :noh<cr>
nnoremap <leader>t :tabs<cr>

nnoremap <leader>cq :cclose<cr>
nnoremap <leader>ch :ColorHighlight<cr>

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <leader><c-u> <esc>viwUea
nnoremap <leader><c-u> viwUe
nnoremap oo o<esc>k
nnoremap OO O<esc>j
nnoremap <leader>p :set paste!<cr>

cnoreabbrev Ack Ack!

" NvimTree
nnoremap <C-e> :NvimTreeToggle<CR>

let g:NERDSpaceDelims = 1

set nowrap
set showmatch
set matchtime=0
set shiftround
set ignorecase
set smartcase
set foldmethod=syntax

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

set completeopt-=preview

" Vim Grepper Config
let g:grepper = {}
let g:grepper.tools = ['rg', 'git', 'grep']
nnoremap <leader>* :Grepper -cword -noprompt<CR>
nnoremap <leader>g :Grepper<CR>

set backupdir=~/.vim/backup/
set directory=~/.vim/backup/
