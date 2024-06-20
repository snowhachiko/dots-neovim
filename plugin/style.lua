Border_style = "single"

-- yank highlight
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- indent blankline
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

-- other
vim.cmd.colorscheme("moonfly")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
require('lspconfig.ui.windows').default_options.border = Border_style
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

