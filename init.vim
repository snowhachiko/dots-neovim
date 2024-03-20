set relativenumber
set numberwidth=3
set softtabstop=4
set tabstop=4
set shiftwidth=4

" use spaces as one tab (formatting)
set expandtab

set smartindent
set autoindent

" search
set ignorecase
set smartcase "use case sensitive only where upper case is in search pattern"

" wraping
set breakindent
set wrap
set linebreak " line break at characters defined in breakat
" wrap only at blank lines (spaces)
set breakat=\ 
" set breakindentopt=min:20

" set nolist wrap linebreak breakat&vim

" only for tabs
" set listchars=tab:\|\ 
set showtabline=1 "0 - never, 1 - when more than one, 2 - always 

set list lcs=tab:\|\ 

"set listchars=tab:\|\ 

set visualbell "no beeping:
set hlsearch "highlight all search results"
set splitbelow
set splitright
set ignorecase
set clipboard=unnamedplus
set fileformats=unix,dos
set shell=/bin/bash

let mapleader = " "

" space for breakpoints
set foldcolumn=0

" disable command line when not entering commands
set cmdheight=0

syntax enable
set fillchars+=vert:\

" Detects XAML files as XML
au BufNewFile,BufRead *.xaml setlocal filetype=xml
au BufNewFile,BufRead *.axaml setlocal filetype=xml
" transparency
" augroup user_colors
"   autocmd!
"   autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
" 	" make number and gutter column transparenthi
" 	autocmd ColorScheme * hi LineNr guibg=NONE
" 	autocmd ColorScheme * hi clear SignColumn
" augroup END

colorscheme moonfly
set termguicolors

" Configure borders for floating windows
autocmd User LspInfoOpen hi LspFloatWinBorder guifg=#00ff00 guibg=NONE gui=NONE cterm=NONE

" highlight Normal ctermbg=NONE guibg=NONE

" apply changes when init.vim saved 
autocmd! BufWritePost $MYVIMRC source %

"autocompletion
set updatetime=300
" set formatoptions-=cro " do not insert comment on new line

lua require('plugins')

" organize imports jdtls-nvim
nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
