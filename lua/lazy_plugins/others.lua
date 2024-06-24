return {
    -- Git integration
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",

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
}
