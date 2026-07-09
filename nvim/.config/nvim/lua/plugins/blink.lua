return {
    'saghen/blink.cmp',
    event = { "BufReadPre", "BufNewFile" },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { 
            preset = 'none',

            ['<Tab>'] = { 'select_next', "fallback" },
            ['<S-Tab>'] = { 'select_prev' },
            ['<C-Return>'] = { 'select_and_accept' },
            ['<C-l>'] = { 'snippet_forward', 'accept', 'fallback' },
            ['<C-h>'] = { 'snippet_backward', 'fallback' },
        },

        appearance = {
            nerd_font_variant = 'mono'
        },
        cmdline = { enabled = true },
        completion = { 
            accept = {
                auto_brackets = { enabled = true },
            },
            documentation = { auto_show = true }, 
            list = { selection = { preselect = false, auto_insert = true },},
            trigger = {show_on_keyword = true },
        },
        snippets = { preset = 'luasnip'},
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },


        fuzzy = { implementation = "prefer_rust_with_warning" },
        -- snippets = { preset = 'luasnip' },
    },
    opts_extend = { "sources.default" }
}
