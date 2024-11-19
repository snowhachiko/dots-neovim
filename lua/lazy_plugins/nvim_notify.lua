return {
    -- 'rcarriga/nvim-notify',
    -- opts = {
    --     background_color = "#110000"
    -- },
    -- config = function()
    --     -- local notify = require("notify").setup()
    --     vim.notify = require("notify")
    -- end

    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        -- add any options here
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    }
}
