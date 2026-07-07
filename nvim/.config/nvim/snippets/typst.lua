local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
        -- 
        -- manual snippets triggered by blink cmp `['<C-j>']`
        --

		s("a", t("also loaded!!")),
	},
	{
        --
        -- autosnippets
        --

		s("qp", { t("$"), i(1), t("$"), i(0) }),
		s("qq", {
			t({ "$", "" }),
			i(1),
			t({ "", "$", "" }),
			i(0),
		}),
}
