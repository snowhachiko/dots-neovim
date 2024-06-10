vim.keymap.set("n", ",fe", vim.cmd.Ex)
-- vim.keymap.set("n", ",fe", ":Oil<CR>")

-- Resizing Continously with ALT
vim.keymap.set('n', '<A-h>', '<C-W>>', { noremap = true })
vim.keymap.set('n', '<A-l>', '<C-W><', { noremap = true })
vim.keymap.set('n', '<A-k>', '<C-W>+', { noremap = true })
vim.keymap.set('n', '<A-j>', '<C-W>-', { noremap = true })

-- quickfix
vim.keymap.set("n", "<leader>]", ":cnext<CR>", { desc = "Forward qfixlist" })
vim.keymap.set("n", "<leader>[", ":cprev<CR>", { desc = "Backward qfixlist" })
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Forward location list"})
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Backward location list"})

-- TELESCOPE
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

--=========== LSP
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- local lsp_zero = require('lsp-zero').preset({})
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
    -- :help lsp-zero-keybindings
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references)
    -- vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = true })

    vim.keymap.set('n', '<leader>e', function()
        vim.diagnostic.open_float(0, { scope = "line" })
    end)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end)
end)

--========= DAP
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)

-- harpoon
local harpoon = require("harpoon")
vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
vim.keymap.set('n', '<leader>`', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set('n', '<C-N>', function() harpoon:list():next() end)
vim.keymap.set('n', '<C-P>', function() harpoon:list():prev() end)


---- comments
-- :help comment.config.Mappings

-- Default comment.nvim mappings

-- gbc -- block comment normal mode
-- gb  -- block comment visual mode

-- Normal mode
-- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
-- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
-- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
-- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
