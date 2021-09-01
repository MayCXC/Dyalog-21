⍝ Ensure there are an even number of rolls between strikes.
ValidStrikes ← ^/2(≤∨=⍥(2∘|))/(⊥⍨¨,\)∘('X'≠⊢)
⍝ Ensure there are an odd number of rolls between spares.
ValidSpares ←  ∧/2(≤∨≠⍥(2∘|))/(⊥⍨¨,\)∘(¯1↓⊢)∘(('/'≠⊢)+('X'=⊢))
⍝ Ensure there is no spare on the first roll, or following strikes and other spares.
ValidRolls ← ~(∨/2('X//'(1∊⍷⍨)⊣,⊢)/⊢)∨('/'=1↑⊢)
⍝ Ensure there are ten frames, with consideration for a third roll on frame ten.
ValidFrames ← 20=(⍴+(+/'X'=(¯3↓⊢))-(∨/'X/'=¯1↓¯3↑⊢))
⍝ Ensure there are at most ten pins knocked down in each frame.
ValidScores ← (∧/10>+/)({∨/'-/'∊⍵: 0 ⋄ (⎕D⍳⍵)-1}¨)∘((2,⍨⌊∘(÷∘2)∘⍴)⍴(-2|⍴)↓⊢)∘(⊢(/⍨)'X'≠⊢)
⍝ The final result is the conjunction of all the other validities, with checks for shape and tally.
ValidGame ← { (1=≢⍴⍵) ∧ (10<⊃((⍴⍵),0)): ⊃(ValidStrikes∧ValidSpares∧ValidRolls∧ValidFrames∧ValidScores)⍵ ⋄ 0}
⍝ Even out each frame by substituting 'X' with 'xx', and reshape the vector into consecutive roll triplets.
BowlingExpand ← ,/(↓⍳10)⌷(⊢, 1⊖⊢, 1⊖⊢)∘(11 2⍴⊃)∘(,/{⍵='X': 'xx' ⋄ ⍵='-': 0 ⋄ ⍵='/': '/' ⋄ ⍎⍵}¨)
⍝ Compute the running total score of each frame.
BowlingBonuses ← {
    ⍵≡6/'x': 30 ⍝ Three strikes.
    ⍵[⍳4]≡4/'x': 20+⍵[5] ⍝ Two strikes.
    ⍵[1,2,4]≡'xx/': 20 ⍝ One strike and one spare.
    ⍵[⍳2]≡'xx': 10+⍵[3]+⍵[4] ⍝ One strike.
    ⍵[2]='/': 10+⍵[3] ⍝ One spare.
    ⍵[1]+⍵[2] ⍝ Open frame.
}
BowlingScore ← {+\BowlingBonuses¨BowlingExpand ⍵}
