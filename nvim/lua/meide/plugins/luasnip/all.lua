return {
    -- s({trig = "helloworld", snippetType = "snippet", desc = "A hellow world example", wordTrig = true},
    --     {t("Just a hint of what's to come!"),})
    s({trig = "defsnippet", snippetType = "snippet", desc = "Boilerplate for snippet definition", wordTrig = true},
        fmta(
            [[
            s({trig = "<>", snippetType = "<>", desc = "<>", wordTrig = <>},
                {t("<>"),}
            ),
            ]],
            { i(1, "trigger"),
              i(2, "snippet"),
              i(3, "description"),
              i(4, "true"),
              i(5, "replace"),}
        )
    ),
}

