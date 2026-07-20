local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local make_condition = require("luasnip.extras.conditions").make_condition


--
-- local functions
--

-- func. to check if in math environment in typst document using treesitter
local in_math = make_condition(function()
	local ok, node = pcall(vim.treesitter.get_node, { ignore_injections = false })
	while ok and node do
		if node:type() == "string" then
			return false
		elseif node:type() == "math" then
			return true
		end
		node = node:parent()
	end
	return false
end)

-- func to simplifiy snippet def.
local function ms(trig, nodes)
	return s({ trig = trig, condition = in_math, show_condition = in_math }, nodes)
end
local function nms(trig, nodes)
	return s({ trig = trig, condition = -in_math, show_condition = -in_math }, nodes)
end

----------------
--- snippets ---
----------------

return {
        --
        -- manual snippets for typst
        --
        nms("ali", {
            t("#align("),
            i(1),
            t({ ")[", "" }),
            i(2),
            t({"", "]", "" }),
            i(0)
        }),

        --
        -- manual math snippets
        --

        ms("par", {
            t("partial "),
            i(1),
            t("/(partial "),
            i(2),
            t(") "),
            i(0)
        })
	}, {
        --
        -- autosnippets for typst
        --

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


        --
        -- in math snippets (use ms(trig, nodes))
        --
        
        -- greek letters
        ms("@a", { t("alpha") }),
        ms("@b", { t("beta") }),
        ms("@g", { t("gamma") }),
        ms("@G", { t("Gamma") }),
        ms("@e", { t("epsilon") }),
        ms("@d", { t("delta") }),
        ms("@D", { t("Delta") }),
        ms("@p", { t("phi") }),
        ms("@z", { t("zeta") }),
        ms("@t", { t("theta") }),
        ms("@T", { t("Theta") }),
        ms("@l", { t("lambda") }),
        ms("@k", { t("kappa") }),
        ms("ome", { t("omega") }),
        ms("Ome", { t("Omega") }),



        -- integral
        ms("intg", { 
            t("integral_("),  
            i(1),
            t(")^("),
            i(2),
            t(") "),
            i(3),
            t(" \"d\""),
            i(0),
        }),
        ms("ointg", { 
            t("integral.cont_("),  
            i(1),
            t(")^("),
            i(2),
            t(") "),
            i(3),
            t(" \"d\""),
            i(0),
        }),

	}
