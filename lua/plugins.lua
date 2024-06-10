--------------------
-- yank highlight --
--------------------
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-------------
-- plugins --
-------------
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
            require'alpha'.setup(require'alpha.themes.startify'.config)
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
    "folke/todo-comments.nvim",
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

    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",

    { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

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

    -- leetcode plugin
    {
        "kawre/leetcode.nvim",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { "nvim-lua/plenary.nvim" }, -- required by telescope
            { "MunifTanjim/nui.nvim" },
            { "rcarriga/nvim-notify" },
        }
    },
})
---

local border_style = "single"

local lsp_zero = require('lsp-zero')

require('mason').setup({
    ui = {
        border = border_style
    }
})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
    }
})
require("mason-nvim-dap").setup()

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

----------------------
-- indent blankline --
----------------------
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "iblIndentColor", { fg = "#5c5c5c" })
end)
require('ibl').setup {
    indent = {
        char = "|",
        highlight = {
            "iblIndentColor"
        },
    },
    whitespace = {
    },
    scope = {
        highlight = { "iblIndentColor" },
        show_start = false,
        show_end = false,
    }
}

-------------
-- styling --
-------------
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
vim.cmd [[colorscheme moonfly]]
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
require('lspconfig.ui.windows').default_options.border = border_style
