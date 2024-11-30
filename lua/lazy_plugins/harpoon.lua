return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local harpoon = require("harpoon")
        -- harpoon:setup()
        vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end)
        vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set('n', '<C-N>', function() harpoon:list():next() end)
        vim.keymap.set('n', '<C-P>', function() harpoon:list():prev() end)
    end
}
