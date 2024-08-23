local conform = require("conform")

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
