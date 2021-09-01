⍝ An array of the largest n equal lengths that will fit in the array.
Short ← ⊣⍴∘⌊÷⍨
⍝ An array of ones for the remaining length of the array.
Long ← ~0×∘⍳|
⍝ Repeat each index by its element to make a partition argument.
Parts ← (⊃,/)∘(⍴⍨⌿↑)∘(⊂∘⍳∘≢,⊂)
⍝ Empty divisions for array lengths less than n.
Pads ← ⊢,⍬(⊂⍨)(,⊣-(≢⊢))
⍝ Sum the short and long lengths to find the shapes of r, then partition and pad to find an answer.
Divvy ← { ⍺Pads(,⍵)(⊆⍨)Parts+⌿↑⍺((⊂Long),(⊂Short))≢⍵ }
