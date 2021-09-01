⍝ Find a greedy fit for ⍵ in ⍺, and produce a mask of aligned indices.
fit ← {(⍺≡'') ∨ (⍵≡''): ⍬ ⋄ ⍺(=⍥⊃)⍵: 1,⍺ fit⍥(1∘↓) ⍵ ⋄ 0,(1↓⍺) fit ⍵}
⍝ Check if ⍺ fits into ⍵, and produce a 2-element vector with the indicator and the indices.
sseq ← { (((''≡⍵)∨(⊂⍬)≢⊢),⊢)⊂⊃(⊢(⊆⍨)⍵=⍥≢⊢)⍸⍺fit⍵ }
⍝ Find the distance from ⍵ to ⍺ using the Needleman–Wunsch algorithm, indels cost one and mismatches cost two.
nwed ← {0=≢⍺⍺: ⍵ ⋄ (⍺+1) ((1↓⍺⍺) nwed ⍵⍵) (⊣(⌊⍨)(1+⊢))/¨(,⍨)\⍺,(1+1↓⍵)⌊(¯1↓⍵)+2×⍵⍵≠⊃⍺⍺}
⍝ Wrap nwed with the initial values for [1;] and [2;1] for use in the Hirschberg algorithm.
nwscore ← {1 (⍵ nwed ⍺) 0,⍳⍴⍺}
⍝ Bisect ⊣ at ⊢
split ← (↑,⍥⊂↓)⍨
⍝ Find the optimal local matches from ⍵ to halves of ⍺ for the divide step.
align ← {(↑⊢,⍥⊂(⍵ split 1(-⍨)(((⊢/⍒)(⍵nwscore⊣)+⍵(⌽nwscore⍥⌽)⊢)/⊢)))⍺ split (≢⍺)(⌈÷)2}
⍝ Find the optimal global matches from ⍵ to ⍺ for the conquer step, lcsqData.txt takes ~ 360s @ 1.6Ghz.
lcsq ← {(⍺≡'') ∨ (⍵≡''): ⍬ ⋄ 1=≢⍺: ⊃⊆(⍺∊⍵)⊂⍺ ⋄ 1=≢⍵: ⍵ lcsq ⍺ ⋄ ((⊃,/)⍣2) lcsq⌿⍺ align ⍵}
