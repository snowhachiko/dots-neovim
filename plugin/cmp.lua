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
        {
            name = 'luasnip',
            -- option = {
            --     show_autosnippets = true,
            --     use_show_condition = false
            -- }
        },
    },
    {
        { name = 'buffer' },
    },
    formatting = {
        -- fields = { 'abbr', 'kind', 'menu' },
        format = function(entry, vim_item)
            if vim.tbl_contains({ 'path' }, entry.source.name) then
                local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
                if icon then
                    vim_item.kind = icon
                    vim_item.kind_hl_group = hl_group
                    return vim_item
                end
            end
            return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
        end,
        -- format = require('lspkind').cmp_format({
        --     mode = 'symbol',
        --     maxwidth = 50,
        --     ellipsis_char = '...',
        --     -- before = function(entry, vim_item)
        --     --     -- vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
        --     --     return vim_item
        --     -- end
        -- })
    },
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered({
            max_width = 100,
        }),
        documentation = cmp.config.window.bordered({
            max_width = 250
        }),
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
