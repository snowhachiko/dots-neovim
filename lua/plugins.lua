vim.cmd [[packadd packer.nvim]]

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
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'williamboman/mason.nvim',
        run = function()
            pcall(vim.cmd, 'MasonUpdate')
        end,
    }

    ---------------------
    ---- UI, visuals ----
    ---------------------
    -- colorschemes
    use 'rebelot/kanagawa.nvim'
    use { "bluz71/vim-moonfly-colors", as = "moonfly" }
    use 'tomasiser/vim-code-dark' --codedark
    use { 'stevearc/dressing.nvim' }
    -- transparent
    use { "xiyaowong/transparent.nvim" }
    -- statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = false }
    }
    -- dashboard
    use {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    }
    -- indent line
    use 'lukas-reineke/indent-blankline.nvim'
    use 'onsails/lspkind.nvim'

    -------------------------------------------
    ---- Fuzzy find, searching, navigating ----
    -------------------------------------------
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    -- switching to tmux panes
    use 'christoomey/vim-tmux-navigator'
    --------------------------------------------

    -- Git integration
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'

    -- sourcegraph cody
    use {
        'sourcegraph/sg.nvim', run = 'nvim -l build/init.lua',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    -- debugging
    use 'mfussenegger/nvim-dap'
    use "jay-babu/mason-nvim-dap.nvim"
    use {
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    }

    -- comments
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -----------------------------
    ---- autocompletion, lsp ----
    -----------------------------
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'

    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason-lspconfig.nvim'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    -- formatting, linting - if not language server
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jay-babu/mason-null-ls.nvim'

    use {
        "folke/trouble.nvim",
        requires = { "nvim-tree/nvim-web-devicons" }
    }

    -- snippets
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*",
        -- install jsregexp (optional!:).
        run = "make install_jsregexp",
        requires = {
            { 'rafamadriz/friendly-snippets' },
            -- { 'honza/vim-snippets' }
        }
    })
    -- show snippets in cmp menu
    use { 'saadparwaiz1/cmp_luasnip' }

    ---- another completion utils ----
    -- html, php, ..  match tags while editing
    use { 'windwp/nvim-ts-autotag' }
    -- autopairs () {} []
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    -- surround
    use({
        "kylechui/nvim-surround",
        tag = "*",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    -- sessions
    -- use {
    --     'rmagatti/auto-session',
    --     -- config = function()
    --     --     require("auto-session").setup {
    --     --         log_level = "error",
    --     --         auto_session_enabled = false,
    --     --         auto_session_create_enabled = false,
    --     --         auto_save_enabled = false,
    --     --         -- auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
    --     --     }
    --     -- end
    -- }
end)

local lsp_zero = require('lsp-zero')

require('mason').setup()
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
    }
})

require('Comment').setup()
require('gitsigns').setup()
require('transparent').setup()
require('lspconfig.ui.windows').default_options.border = 'single'

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

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
