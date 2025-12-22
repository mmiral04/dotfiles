return {
    -- Commands
    s({trig = "documentclass", snippetType = "autosnippet", desc = "Document class command", wordTrig = false},
       fmta(
            [[
                \documentclass{<>}
            ]],
            {
                i(1, "")
            }
        ) 
    ),

    s({trig = "usepackage", snippetType = "autosnippet", desc = "Use package command", wordTrig = false},
       fmta(
            [[
                \usepackage[<>]{<>} 
            ]]
            , {
                i(1, ""),
                i(2, "")
            }) 
    ),
    
    s({trig = "emph", snippetType = "autosnippet", desc = "Emphasis command", wordTrig = false},
       fmta(
            [[
                \emph{<>}
            ]],
            {
                i(1,"")
            }
        ) 
    ),

    s({trig = "textit", snippetType = "autosnippet", desc = "Text italic command", wordTrig = false},
        fmta(
            [[
                \textit{<>}       
            ]],
            {
                i(1, "")
            }
        )
    ),
}

