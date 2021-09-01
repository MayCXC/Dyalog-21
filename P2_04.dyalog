⍝ Take the pairwise slopes and measure the length of each plateau, i.e.:
⍝ 2(the inflection points)/({the signed distance from last nonzero slope}/¨)∘(the graph's deltas)
inflections ← 2(⊣×≠⍥×)/({⍺=0: ⍵+×⍵ ⋄ ⍺}/¨)∘(,⍨\2(<->)/⊢)
⍝ Find the midpoints of each plateau.
extremes ← {1+(0≠⍵)/((⍳⍴⍵)-2(÷⍨)1<|⍵)}
⍝ Ignore short inputs, otherwise compute the midpoints from the extrema of the inflections.
MinMax ← {3>≢⍵: ⍬ ⋄ extremes inflections ⍵}
