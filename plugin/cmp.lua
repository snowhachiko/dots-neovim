local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
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

local lspkind = require('lspkind')

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
        -- fields = { "abbr", "menu", "kind" },
        format = lspkind.cmp_format({
            maxwidth = 60,
            mode = 'symbol',
            ellipsis_char = '...',
        })
        -- format = function(entry, item)
        --
        --     local item = lspkind.cmp_format({ with_text = false })(entry, item)
        --
        --     -- Define menu shorthand for different completion sources.
        --     -- local menu_icon = {
        --     --     nvim_lsp = "NLSP",
        --     --     nvim_lua = "NLUA",
        --     --     luasnip  = "LSNP",
        --     --     buffer   = "BUFF",
        --     --     path     = "PATH",
        --     -- }
        --
        --     -- Set the menu "icon" to the shorthand for each completion source.
        --     -- item.menu = menu_icon[entry.source.name]
        --
        --     -- Set the fixed width of the completion menu to 60 characters.
        --     -- fixed_width = 20
        --
        --     -- Set 'fixed_width' to false if not provided.
        --     fixed_width = fixed_width or false
        --
        --     -- Get the completion entry text shown in the completion window.
        --     local content = item.abbr
        --
        --     -- Set the fixed completion window width.
        --     if fixed_width then
        --         vim.o.pumwidth = fixed_width
        --     end
        --
        --     -- Get the width of the current window.
        --     local win_width = vim.api.nvim_win_get_width(0)
        --
        --     -- Set the max content width based on either: 'fixed_width'
        --     -- or a percentage of the window width, in this case 20%.
        --     -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
        --     local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)
        --
        --     -- Truncate the completion entry text if it's longer than the
        --     -- max content width. We subtract 3 from the max content width
        --     -- to account for the "..." that will be appended to it.
        --     if #content > max_content_width then
        --         item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
        --     else
        --         item.abbr = content .. (" "):rep(max_content_width - #content)
        --     end
        --     return item
        -- end,

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
