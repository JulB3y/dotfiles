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
            ['<C-Return>'] = { 'accept' },
            ['<C-l>'] = { 'accept', 'snippet_forward', 'fallback' },
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
