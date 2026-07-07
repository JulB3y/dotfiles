local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local make_condition = require("luasnip.extras.conditions").make_condition

local in_math = make_condition(function()
	local ok, node = pcall(vim.treesitter.get_node, { ignore_injections = false })
	while ok and node do
		if node:type() == "math" then
			return true
		end
		node = node:parent()
	end
	return false
end)

return {
		s("a", t("also loaded!!")),
	}, {
		s(
			{ trig = "qp", condition = -in_math, show_condition = -in_math },
			{ t("$"), i(1), t("$"), i(0) }
		),
		s({ trig = "qq", condition = -in_math, show_condition = -in_math }, {
			t({ "$", "" }),
			i(1),
			t({ "", "$", "" }),
			i(0),
		}),
        s({ trig = "del", condition = in_math, show_condition = in_math }, {
            t({"delta", ""})
        })
	}
