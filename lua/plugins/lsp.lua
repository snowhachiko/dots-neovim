-- local cmp_lsp = require("cmp_nvim_lsp")
-- local capabilities = vim.tbl_deep_extend(
--     "force",
--     {},
--     vim.lsp.protocol.make_client_capabilities(),
--     cmp_lsp.default_capabilities())

local lspconfig = require('lspconfig')
local lsp_configs_path = 'lspconfig.server_configurations'

local win = require('lspconfig.ui.windows')
win.default_options.border = Border_style

require('mason-lspconfig').setup({
    ensure_installed = { 'clangd', 'lua_ls', 'omnisharp' },
    handlers = {
        -- default setup of installed servers
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,

        -- custom setups
        emmet_language_server = function()
            local emmet_config_path = lsp_configs_path .. '.emmet_language_server'
            local emmet_default_config = require(emmet_config_path).default_config

            local filetypes = emmet_default_config.filetypes
            table.insert(filetypes, 'php')

            lspconfig.emmet_language_server.setup({
                filetypes = filetypes
            })
        end,

        clangd = function()
            lspconfig.clangd.setup({
                cmd = {
                    "clangd",
                    "--fallback-style=webkit",
                },
                autostart = true
            })
        end,

        lua_ls = function()
            lspconfig.lua_ls.setup {
                -- capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            }
        end,
    },
})
-- allow using system wide installation
-- rustaceanvim may conflict
-- lspconfig.rust_analyzer.setup {
--     capabilities = capabilities
-- }
