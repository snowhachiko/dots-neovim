local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        -- Replace these with the tools you have installed
        -- make sure the source name is supported by null-ls
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
        null_ls.builtins.formatting.prettier.with({
            -- disabled_filetypes = { "javascript" },
            disabled_filetypes = { "html" },
            -- extra_args = { "--tab-width", "4" }
        }),
        -- null_ls.builtins.diagnostics.eslint_d,
        -- null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.jsonlint,
        -- null_ls.builtins.formatting.clang_format,
        -- null_ls.builtins.formatting.phpcsfixer,
        -- null_ls.builtins.formatting.stylua,
    }
})
