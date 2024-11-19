return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        local conform = require("conform")

        vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500
            })
        end)

        conform.setup({
            formatters_by_ft = {
                json = { "prettierd" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
            },
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })
    end
}
