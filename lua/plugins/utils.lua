require('todo-comments').setup()
require('gitsigns').setup()

local harpoon = require("harpoon")
vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
vim.keymap.set('n', '<leader>`', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set('n', '<C-N>', function() harpoon:list():next() end)
vim.keymap.set('n', '<C-P>', function() harpoon:list():prev() end)
harpoon:setup()
