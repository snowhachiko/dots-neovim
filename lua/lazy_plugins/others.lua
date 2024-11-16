return {

    {
        "williamboman/mason.nvim",
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        "tpope/vim-fugitive",
    },

    -- switching to tmux panes
    {
        "christoomey/vim-tmux-navigator",
    },

    -- TODO highlight and list
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- comment
    { "numToStr/Comment.nvim" },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },

    -- html, php, ..  match versions while editing
    { "windwp/nvim-ts-autotag" },

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

    -- colorschemes
    "rebelot/kanagawa.nvim",
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },

    -- improve default vim.ui interfaces
    { "stevearc/dressing.nvim" },

    -- transparent
    { "xiyaowong/transparent.nvim" },

    config = function()
        require('todo-comments').setup()
        require('gitsigns').setup()
        -- require('transparent').setup()
    end
}
