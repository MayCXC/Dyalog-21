⍝ Isolate the bounds of each range. Partition commas first, then the first hyphen after the first character.
MakeBounds ← (⍎¨↑)(((~(<\0,1↓'-'=⊢))⊆⊢)¨((','≠⊢)⊆⊢))
⍝ Arithmetic sequence from ⍺ to ⍵ by ×(⍵-⍺).
to ← >{⌽(⍣⍺)⍵}⌊,⌊+(⍳⌈-⌊)
⍝ Check for null, then fill the bounds with sequences, and flatten the result.
MakeList ← {0<⍴(,⍵): ⊃,/to/MakeBounds, ⍵ ⋄ ⍬}
