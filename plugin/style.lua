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

-- colorscheme
local function set_colorscheme(name)
  local ok, _ = pcall(vim.cmd, 'colorscheme ' .. name)
  if not ok then
    vim.notify('Colorscheme ' .. name .. ' not found!', vim.log.levels.WARN)
  end
end

-- other
set_colorscheme("moonfly")
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- require('lspconfig.ui.windows').default_options.border = Border_style
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

