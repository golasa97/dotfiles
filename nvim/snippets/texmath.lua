local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node



ls.add_snippets("tex", {
    -- Superscript (Exponent)
    s({trig = "^", wordTrig= false}, {
        t("^{"),
        i(1, "exponent"),
        t("}"),
    }),

    -- Subscript (Exponent)
    s({trig = "_", wordTrig= false}, {
        t("_{"),
        i(1, "subscript"),
        t("}"),
    }),

}, {
    type = "autosnippets",
})


ls.add_snippets("tex", {
    s("eqn", {
        t({ "\\begin{equation}"}),
        t({"", "\t\\label{eq:"}),
        i(1, "label"),
        t({"}", "\t"}),
        i(2, "E=mc^2"),
        t({"", "\\end{equation}" })
    }),
    -- Fraction
    s("frac", {
        t("\\frac{"),
        i(1, "numerator"),
        t("}{"),
        i(2, "denominator"),
        t("}"),
    }),


    -- Integral
    s("int", {
        t("\\int_{"),
        i(1, "a"),
        t("}^{"),
        i(2, "b"),
        t("} "),
        i(3, "integrand"),
        t("\\, d"),
        i(4, "x"),
    }),

    -- Summation
    s("sum", {
        t("\\sum_{"),
        i(1, "i=1"),
        t("}^{"),
        i(2, "n"),
        t("} "),
        i(3, "expression"),
    }),

    -- Product
    s("prod", {
        t("\\prod_{"),
        i(1, "i=1"),
        t("}^{"),
        i(2, "n"),
        t("} "),
        i(3, "expression"),
    }),

    -- Square Root
    s("sqrt", {
        t("\\sqrt{"),
        i(1, "expression"),
        t("}"),
    }),

    -- nth Root
    s("nroot", {
        t("\\sqrt["),
        i(1, "n"),
        t("]{"),
        i(2, "expression"),
        t("}"),
    }),

    -- Absolute Value
    s("abs", {
        t("\\left|"),
        i(1, "expression"),
        t("\\right|"),
    }),

    -- Norm
    s("norm", {
        t("\\left\\|"),
        i(1, "expression"),
        t("\\right\\|"),
    }),

    -- Parentheses
    s("par", {
        t("\\left("),
        i(1, "expression"),
        t("\\right)"),
    }),

    -- Brackets
    s("brack", {
        t("\\left["),
        i(1, "expression"),
        t("\\right]"),
    }),

    -- Derivative
    s("der", {
        t("\\frac{d"),
        i(1, "y"),
        t("}{d"),
        i(2, "x"),
        t("}"),
    }),

    -- Partial Derivative
    s("pder", {
        t("\\frac{\\partial "),
        i(1, "L"),
        t("}{\\partial "),
        i(2, "x"),
        t("}"),
    }),

})
