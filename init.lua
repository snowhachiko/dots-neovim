vim.cmd[[
" set relativenumber
set numberwidth=3
set softtabstop=4
set tabstop=4
set shiftwidth=4
set number

set expandtab " use spaces as one tab (formatting)

set smartindent
set autoindent

set ignorecase " search
set smartcase " use case sensitive only where upper case is in search pattern"

" wraping
set breakindent
set wrap
set linebreak " line break at characters defined in breakat
" wrap only at blank lines (spaces)
set breakat=\  
" set breakindentopt=min:20

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

set foldcolumn=0 " space for breakpoints

set cmdheight=0 " disable command line when not entering commands

set fillchars+=vert:\

" Detects XAML files as XML
au BufNewFile,BufRead *.xaml setlocal filetype=xml
au BufNewFile,BufRead *.axaml setlocal filetype=xml

set termguicolors
syntax enable

" Configure borders for floating windows
autocmd User LspInfoOpen hi LspFloatWinBorder guifg=#00ff00 guibg=NONE gui=NONE cterm=NONE

" apply changes when init.vim saved 
" autocmd! BufWritePost $MYVIMRC source %

" autocompletion
set updatetime=250

" set formatoptions-=cro " do not insert comment on new line

]]

-- vim.cmd('autocmd BufRead * echomsg "bufread event"')
-- vim.cmd('autocmd BufAdd * echomsg " event"')
-- vim.cmd('autocmd BufCreate * echomsg " event"')
-- -- vim.cmd('autocmd FileType * echomsg "filetype event "..&filetype')
-- -- vim.cmd('autocmd BufReadPost * echomsg "bufreadpost event"')
-- vim.cmd('autocmd VimEnter * echomsg "vimenter event"')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    { "williamboman/mason.nvim" },

    ---------------------
    ---- UI, visuals ----
    ---------------------
    -- colorschemes
    "rebelot/kanagawa.nvim",
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
    { "stevearc/dressing.nvim" },
    -- transparent
    { "xiyaowong/transparent.nvim" },
    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = false }
    },
    -- dashboard
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    },
    -- indent line
    "lukas-reineke/indent-blankline.nvim",
    -- pictograms to lsp
    "onsails/lspkind.nvim",

    -------------------------------------------
    ---- Fuzzy find, searching, navigating ----
    -------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    -- switching to tmux panes
    "christoomey/vim-tmux-navigator",

    -- TODO highlight and list
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    -- file explorer, edit FS like buffer
    -- oil.nvim
    --------------------------------------------

    -- Git integration
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",

    -- debugging
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    },

    -- comment
    { "numToStr/Comment.nvim" },

    -----------------------------
    ---- autocompletion, lsp ----
    -----------------------------
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",

    { "VonHeikemen/lsp-zero.nvim",         branch = "v3.x" },
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason-lspconfig.nvim" },

    { "nvim-treesitter/nvim-treesitter",   build = ":TSUpdate" },

    -- formatting, linting - if not language server
    "jose-elias-alvarez/null-ls.nvim",
    "jay-babu/mason-null-ls.nvim",

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },

    -- snippets
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            { "rafamadriz/friendly-snippets" },
            -- { "honza/vim-snippets" }
        }
    },
    -- show snippets in cmp menu
    { "saadparwaiz1/cmp_luasnip" },

    ---- another completion utils ----
    -- html, php, ..  match versions while editing
    { "windwp/nvim-ts-autotag" },
    -- autopairs () {} []
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },
    -- surround
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to defaults
            })
        end
    },

}, {
    ui = {
        backdrop = 50,
        border = Border_style
    },
})

--------------------
-- plugins config --
--------------------
require('mason').setup({
    ui = { border = Border_style }
})

-- lsp/lsp-zero
local lspconfig = require('lspconfig')
local lsp_zero = require('lsp-zero')
local lsp_configs_path = 'lspconfig.server_configurations'

require('mason-lspconfig').setup({
    ensure_installed = { 'clangd', 'lua_ls', 'omnisharp' },
    handlers = {
        -- default setup of installed servers
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,

        -- custom setups
        emmet_language_server = function()
            local emmet_config_path = lsp_configs_path .. '.emmet_language_server'
            local emmet_default_config = require(emmet_config_path).default_config

            local filetypes = emmet_default_config.filetypes
            table.insert(filetypes, 'php')

            lspconfig.emmet_language_server.setup({
                filetypes = filetypes
            })
        end,

        clangd = function()
            lspconfig.clangd.setup({
                cmd = {
                    "clangd",
                    "--fallback-style=webkit",
                },
                autostart = true
                -- single_file_support = true,
                -- root_dir = lspconfig.util.root_pattern('.')
            })
        end,

    },
})

-- allow using system wide installation
lspconfig.rust_analyzer.setup {}

require('todo-comments').setup()
require('gitsigns').setup()
require('transparent').setup()

local harpoon = require("harpoon")
harpoon:setup()

require('telescope').setup({
    defaults = {
        previewer = true,
        preview_cutoff = 1,
        layout_strategy = "flex",
    }
})
require('telescope').load_extension "file_browser"
