require("set")
require("lazy_init")

require('todo-comments').setup()
require('gitsigns').setup()
-- require('transparent').setup()

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
