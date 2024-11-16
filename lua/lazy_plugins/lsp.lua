-----------------------------
---- autocompletion, lsp ----
-----------------------------

return {
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        lazy = false,   -- This plugin is already lazy
        config = function()

        end
    },

    -- autopairs () {} []
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "saadparwaiz1/cmp_luasnip",

            -- pictograms for cmp
            "onsails/lspkind.nvim",
        },

        config = function()
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())

            local lspconfig = require('lspconfig')
            local lsp_configs_path = 'lspconfig.server_configurations'

            require('mason').setup({
                ui = { border = Border_style }
            })
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

                    omnisharp = function()
                        lspconfig.omnisharp.setup({
                            capabilities = capabilities
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
                            capabilities = capabilities,
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
        end
    },


}
