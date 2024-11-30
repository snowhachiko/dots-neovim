local config = function()
    vim.keymap.set('n', '<leader>te', '<Cmd>Neotree toggle left<CR>')
    vim.keymap.set('n', '<leader>tb', '<Cmd>Neotree toggle left source=buffers<CR>')
    vim.keymap.set('n', '<leader>tf', '<Cmd>Neotree toggle float<CR>')

    require("neo-tree").setup({
        default_component_configs = {
            git_status = {
                symbols = {
                    modified = "",
                    added = ""
                }
            }
        }
    })
end

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = config
}
