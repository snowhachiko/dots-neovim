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
-- vim.cmd.colorscheme("moonfly")

local function set_colorscheme(name)
  local ok, _ = pcall(vim.cmd, 'colorscheme ' .. name)
  if not ok then
    vim.notify('Colorscheme ' .. name .. ' not found!', vim.log.levels.WARN)
  end
end

set_colorscheme('moonfly')

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

vim.g.rustaceanvim = {
    tools = {
        float_win_config = {
            border = Border_style
        }
    }
}
