-- formatting
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.foldcolumn = "0" -- space for breakpoints
vim.opt.fillchars:append({ vert = "\\" })

vim.opt.expandtab = true -- use spaces as one tab (formatting)

-- Indentation
vim.opt.smartindent = true
vim.opt.autoindent = true

-- search options
vim.opt.ignorecase = true
vim.opt.smartcase = true -- use case sensitive only where upper case is in search pattern"
vim.opt.hlsearch = true  -- highlight all search results"

-- wraping
vim.opt.breakindent = true
vim.opt.wrap = true
vim.opt.linebreak = true -- line break at characters defined in breakat
vim.opt.breakat = "\\"   -- wrap only at blank lines (spaces)
-- vim.opt.breakindentopt=min:20

-- only for tabs
vim.opt.showtabline = 1 -- 0 - never, 1 - when more than one, 2 - always

-- listchars
vim.opt.list = true
vim.opt.listchars = { tab = "| " }

vim.opt.visualbell = true -- no beeping
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.clipboard = "unnamedplus"
vim.opt.fileformats = { "unix", "dos" }
vim.opt.shell = "/bin/bash"

vim.opt.complete = ""
-- Disable <C-p> and <C-n> in insert mode without outputting ^P or ^N
vim.api.nvim_set_keymap('i', '<C-p>', '<C-o>:<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-n>', '<C-o>:<CR>', { noremap = true, silent = true })

vim.g.mapleader = " "

vim.opt.updatetime = 150

vim.opt.cmdheight = 0 -- disable command line when not entering commands


-- Detects XAML files as XML
vim.cmd [[
    au BufNewFile,BufRead *.xaml setlocal filetype=xml
    au BufNewFile,BufRead *.axaml setlocal filetype=xml
    "autocmd User LspInfoOpen hi LspFloatWinBorder guifg=#00ff00 guibg=NONE gui=NONE cterm=NONE
]]

vim.opt.termguicolors = true
vim.cmd [[syntax enable]]

-- Configure borders for floating windows

-- apply changes when init.vim saved
-- autocmd! BufWritePost $MYVIMRC source %

-- vim.opt.formatoptions-=cro " do not insert comment on new line
