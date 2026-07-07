return {
	"L3MON4D3/LuaSnip",
	version = "v2.*", 
	build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")
        ls.setup({
            enable_autosnippets = true
        })
        require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
    end,
}

