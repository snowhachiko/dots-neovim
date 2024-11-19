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

local function set_colorscheme(name)
    local ok, _ = pcall(vim.cmd, 'colorscheme ' .. name)
    if not ok then
        vim.notify('Colorscheme ' .. name .. ' not found!', vim.log.levels.WARN)
    end
end

-- set_colorscheme("onedark")
set_colorscheme("moonfly")

vim.g.rustaceanvim = {
    tools = {
        float_win_config = {
            border = Border_style
        }
    }
}
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- require('lspconfig.ui.windows').default_options.border = Border_style
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

-- Configure borders for floating windows
-- vim.opt.pumblend = 0
-- local float = { focusable = true, style = "minimal", border = "rounded", }
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)
-- vim.lsp.handlers["textDocument/diagnostics"] = vim.lsp.with(vim.lsp.handlers.diagnostics, float)
