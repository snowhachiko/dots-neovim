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

-- vim.cmd.colorscheme("kanagawa")
vim.cmd.colorscheme("moonfly")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

vim.g.rustaceanvim = {
    tools = {
        float_win_config = {
            border = Border_style
        }
    }
}
