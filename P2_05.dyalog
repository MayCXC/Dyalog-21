⍝ The ⍺th cartesian power of ⍵, ⍵ can be a vector or a string.
lexf ← {⍺>0: (,∘.,)⍣(⍺-1)⍨,¨⍵ ⋄ ⊂⍬}
⍝ Insert ⍺ into ⍵ at the largest equal intervals possible.
evenly ← {,((≢⍺) 1⍴⍺),((≢⍺) (⍵÷⍥≢⍺)⍴⍵)}
⍝ The first ⍺ cartesian powers of ⍵ in lexicographic order.
lexv ← {⊃evenly/lexf∘⍵¨⍳⍺}
