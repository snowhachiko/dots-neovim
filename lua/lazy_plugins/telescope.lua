local config = function()
    require('telescope').setup({
        defaults = {
            previewer = true,
            preview_cutoff = 1,
            layout_strategy = "flex",
        }
    })

    local telescope = require('telescope');
    telescope.load_extension "file_browser"

    local file_browser = telescope.load_extension "file_browser"
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
    vim.keymap.set('n', ',fp', ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
    -- vim.keymap.set('n', '<c-d>', actions.delete_buffer, {})
end

return {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = {
        "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
    config = config
}
