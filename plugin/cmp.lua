local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- local cmp_action = require('lsp-zero').cmp_action()
-- local cmp_format = require('lsp-zero').cmp_format({ details = true })
local luasnip = require("luasnip")

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

cmp.setup({
    sources = {
        {
            name = 'luasnip',
            option = {
                show_autosnippets = true,
                use_show_condition = false
            }
        },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
    },
    {
        { name = 'buffer' },
    },
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = require('lspkind').cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...'
        })
    },
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            select = false,
        }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
                -- elseif has_words_before() then
                -- 	cmp.complete()
            elseif vim.fn.pumvisible() == 1 then
                cmp.confirm()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
})

-- cmp.setup({
--     formatting = cmp_format,
--     preselect = cmp.PreselectMode.None,
--     snippet = {
--         -- REQUIRED - you must specify a snippet engine
--         expand = function(args)
--             require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--         end,
--     },
--     window = {
--         completion = cmp.config.window.bordered(),
--         documentation = cmp.config.window.bordered(),
--     },
--     mapping = cmp.mapping.preset.insert({
--         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<C-e>'] = cmp.mapping.abort(),
--         ['<CR>'] = cmp.mapping.confirm({
--             select = false,
--
--         }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--
--         ["<Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif luasnip.expand_or_jumpable() then
--                 luasnip.expand_or_jump()
--                 -- elseif has_words_before() then
--                 -- 	cmp.complete()
--             elseif vim.fn.pumvisible() == 1 then
--                 cmp.confirm()
--             else
--                 fallback()
--             end
--         end, { "i", "s" }),
--
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif luasnip.jumpable(-1) then
--                 luasnip.jump(-1)
--             else
--                 fallback()
--             end
--         end, { "i", "s" }),
--
--     }),
--     sources = cmp.config.sources({
--         { name = 'nvim_lsp' },
--         { name = 'nvim_lsp_signature_help' },
--         { name = 'luasnip' }, -- For luasnip users.
--     }, {
--         { name = 'buffer' },
--     })
-- })


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
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})