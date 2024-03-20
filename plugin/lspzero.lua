local lspconfig = require('lspconfig')
lspconfig.emmet_language_server.setup({
    filetypes = {
        "astro",
        "css",
        "eruby",
        "html",
        "htmldjango",
        "javascriptreact",
        "less",
        "php",
        "pug",
        "sass",
        "scss",
        "svelte",
        "typescriptreact",
        "vue",
    },
})
lspconfig.rust_analyzer.setup {
    -- make rustfmt work on standalone file
    root_dir = function(fname)
        return lspconfig.util.root_pattern(
            'Cargo.toml', 'rust-project.json'
        )(fname) or vim.fn.getcwd()
    end
}
--
lspconfig.clangd.setup {
    cmd = {
        "clangd",
        "--fallback-style=webkit",
    }
}
--
