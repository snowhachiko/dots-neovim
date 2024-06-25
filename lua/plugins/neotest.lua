local neotest = require("neotest")
neotest.setup({
    adapters = {
        require("rustaceanvim.neotest")
    }
})

vim.keymap.set("n", "<leader>tc", function()
    neotest.run.run()
end)
