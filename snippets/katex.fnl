[
 (s {:trig ";m" :desc "Inline math with markdown-it gitlab style"}
    (fmta "$`<>`$" [(i 1)]))

 (s {:trig "mm" :desc "Block math with markdown-it gitlab style"}
    (fmta "```math\n<>\n```" [(i 1)]))

 (s {:trig "vec"}
    (fmta "\\mathbf{\\overrightarrow{<>}}" [(i 1)]))
 
 (s {:trig "vec_len"}
    (fmta "\\mathbf{|\\overrightarrow{<>}|}" [(i 1)]))

 (s {:trig "angle"}
    (fmta "\\langle <>\\rangle" [(i 1)]))
 
 (s :ff
    (fmta "\\frac{<>}{<>}" 
          [(i 1) (i 2)]))
]
