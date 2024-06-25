require('telescope').setup({
    defaults = {
        previewer = true,
        preview_cutoff = 1,
        layout_strategy = "flex",
    }
})
-- require('telescope').load_extension "file_browser"

local builtin = require('telescope.builtin')
local utils = require('telescope.utils')
-- local actions = require('telescope.actions')
-- vim.keymap.set('n', ',ff',
--     function()
--         -- builtin.find_files({ cwd = utils.buffer_dir() })
--         builtin.find_files({ cwd = vim.fn.getcwd() })
--     end, {})
vim.keymap.set('n', ',ff', builtin.find_files, {})
vim.keymap.set('n', ',fb', builtin.buffers, {})
vim.keymap.set('n', ',fh', builtin.help_tags, {})
vim.keymap.set('n', ',fg', builtin.git_files, {})
vim.keymap.set('n', ',fr', builtin.lsp_references, {})
vim.keymap.set('n', ',fc', builtin.git_commits, {})
vim.keymap.set('n', ',ft', function() vim.api.nvim_command(":TodoTelescope") end, {})
-- vim.keymap.set('n', '<c-d>', actions.delete_buffer, {})
