return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            'mrcjkb/rustaceanvim',

            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local neotest = require("neotest")
            neotest.setup({
                adapters = {
                    require("rustaceanvim.neotest")
                }
            })

            vim.keymap.set("n", "<leader>tc", function()
                neotest.run.run()
            end)
        end,
    },
}
