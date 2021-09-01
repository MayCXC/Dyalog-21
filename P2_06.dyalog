⍝ The number of cells each ship occupies in each row.
RowCounts ← {+/(⍳⍺)∘=¨⍵}
⍝ A ship fits in a row iff:
⍝ It occupies one or none of the cells in each column ∧
⍝ It only occupies one row ∧
⍝ It only occupies adjacent columns ∧
⍝ It occupies exactly as many columns as it does cells in its row.
⍝ If all of the above are true, return its length.
RowFits ← {(∧/⍺∊(0 1)) ∧ (1=+/⍵≠0) ∧ (((1,2∧/⊣)=⍥(+/)⊢)⍨ ⍺) ∧ (⍺=⍥(+/)⍵) × +/⍵}
⍝ A ship is straight iff it fits in a single row or column.
Straight ← RowFits∨RowFits⍨
⍝ The width and height of every ship on the board.
BoardFleet ← {,⌿↑⍉↑⍺∘RowCounts¨(⍵ (⍉⍵))}
⍝ A board is valid iff:
⍝ It has shape ⍺⍺ ∧
⍝ It has at most ⍴⍵⍵ ships ∧
⍝ Its ships are are all straight ∧
⍝ Its ships have lengths ⍵⍵
ValidBoard ← {⍺⍺≡0 0: ⍵⍵≡⍬ ⋄ (⍺⍺≡⍴⍵) ∧ (∧/,⍵∊0,⍳⍴⍵⍵) ∧ (⍵⍵≡Straight⌿(⍴⍵⍵)BoardFleet⍵)}
⍝ A ship is diagonal iff:
⍝ It occupies at most one cell in each row and column ∧
⍝ It only occupies adjacent rows and columns ∧
⍝ It has has equal width and height.
⍝ If the above are true, return its length.
Diagonal ← {(∧/(⍺,⍵)∊(0 1)) ∧ (∧/((1,2∧/⊣)=⍥(+/)⊢)⍨¨(⍺ ⍵)) ∧ (∧/=⍥(+/)⍨¨(⍺ ⍵)) × +/⍵ }
⍝ Two ships are crossed if each occupies two opposite corners of a 2x2 rectangle.
Crossed ← ∨/(∧/0<,∘⊢ ∧ ⊢∧⍥(=/(1 1)∘⍉)⌽∘⊢)¨∘(,(⊂⊢)⌺2 2)
⍝ A board is a ValidBoard2 if it is a ValidBoard, allowing for diagonal ships, but not crossed ships.
ValidBoard2 ← {⍺⍺≡0 0: ⍵⍵≡⍬ ⋄ (⍺⍺≡⍴⍵) ∧ (∧/,⍵∊0,⍳⍴⍵⍵) ∧ (⍵⍵≡(Straight∨Diagonal)⌿(⍴⍵⍵) BoardFleet ⍵) ∧ (~Crossed ⍵)}
