vim.keymap.set("n", ",fe", vim.cmd.Ex)

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

---------------------
-------- LSP --------
---------------------

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist)

local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references)
        -- vim.keymap.set('n', ',gr', '<cmd>Telescope lsp_references<cr>', { buffer = true })

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
        -- vim.keymap.set('n', '<leader>f', function()
        --     vim.lsp.buf.format { async = true }
        -- end)
        -- vim.keymap.set('n', '<leader>f', function()
        --     vim.lsp.buf.format {
        --         async = true,
        --         filter = function(client) return client.name ~= "tsserver" end
        --     }
        -- end)
    end
})

---------------------
-------- DAP --------
---------------------
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<Leader>dc', function() require('dap').close() end)
vim.keymap.set('n', '<Leader>dt', function() require('dap').terminate() end)

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

-- neotest
local has_neotest, neotest = pcall(require, "neotest")
if has_neotest then
    -- run nearest test
    vim.keymap.set("n", "<leader>tr", function()
        neotest.run.run()
    end)
    vim.keymap.set('n', '<Leader>td', function()
        neotest.run.run({ strategy = "dap" })
    end)

    -- stop
    vim.keymap.set('n', '<Leader>ts', function()
        neotest.run.stop(vim.fn.expand("%"))
    end)

    vim.keymap.set('n', '<Leader>tt', function()
        neotest.summary.toggle()
    end)
end
