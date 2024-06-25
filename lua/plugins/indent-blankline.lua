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
