local config = function()
    require('nvim-autopairs').setup()

    local cmp = require('cmp')
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local luasnip = require("luasnip")
    local lspkind = require('lspkind')

    require("luasnip.loaders.from_vscode").lazy_load()
    -- require('luasnip.loaders.from_snipmate').lazy_load()

    -- If you want insert `(` after select function or method item
    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
    )

    local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local function prev_item(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end

    local function next_item(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end

    cmp.setup({
        sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'luasnip' },
        },
        {
            { name = 'buffer' },
            { name = 'nvim_lua' },
        },
        formatting = {
            fields = { "abbr", "kind", "menu" },
            format = lspkind.cmp_format({
                maxwidth = 60,
                mode = 'symbol',
                ellipsis_char = '...',
            })
        },
        preselect = cmp.PreselectMode.None,
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        view = {
            docs = { auto_open = true },
            entries = {
                -- name = "custom",
                selection_order = "near_cursor",
                follow_cursor = true,
            },
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping({
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),

            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),

            ['<CR>'] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    else
                        fallback()
                    end
                end,
                s = cmp.mapping.confirm({ select = false }),
                c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            }),

            ["<Tab>"] = cmp.mapping(next_item, { "i", "s" }),
            ["<C-n>"] = cmp.mapping(next_item, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(prev_item, { "i", "s" }),
            ["<C-p>"] = cmp.mapping(prev_item, { "i", "s" }),

            ['<C-q>'] = cmp.mapping(function(fallback)
                if cmp.visible_docs() then
                    cmp.close_docs()
                elseif cmp.visible() then
                    cmp.open_docs()
                else
                    fallback()
                end
            end)
        }),
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'cmp_git' },
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline({}),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
            ['<C-p>'] = cmp.config.disable,
            ['<C-n>'] = cmp.config.disable
        }),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            {
                name = 'cmdline',
                option = {
                    ignore_cmds = { 'Man', '!' }
                }
            }
        })
    })
end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = {
                { "rafamadriz/friendly-snippets" },
                -- { "honza/vim-snippets" }
            }
        },
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },

    config = config
}
