---------------------
---- UI, visuals ----
---------------------

return {
    -- colorschemes
    "rebelot/kanagawa.nvim",
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },

    -- improve default vim.ui interfaces
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
}
