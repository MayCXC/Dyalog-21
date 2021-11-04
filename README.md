# Dyalog APL Problem Solving Competition 2021
https://www.dyalog.com/news/147/420/Meet-The-2021-APL-Problem-Solving-Competition-Winners.htm

## Overview
The competition consists of two parts:

- **Phase 1** asks you to solve 10 puzzles by writing short APL functions, allowing you to demonstrate array-oriented thinking. You can begin without registering — your solutions should be stored by your browser until you decide to register and submit them (not all browsers do this).
- **Phase 2** comprises a collection of more difficult problems, each having one or two tasks. In addition to requiring array-oriented thinking, this enables you to show off your ability to write larger amounts of well-documented, high-quality, code.

The problem specifications given on this site can also be downloaded as PDF files:

[PDF of the Phase 1 problem set](https://www.dyalogaplcompetition.com/Downloads/Phase%201%20Problems.pdf)

[PDF of the Phase 2 problem set](https://www.dyalogaplcompetition.com/Downloads/Phase%202%20Problems.pdf)

## Approach
APL lets you do most kinds iteration and reduction with symbolic operators, and compose these into dense functions with "glue" operators. There are three syntaxes to choose from for a function definition, which are called a tradfn, dfn, or tacit function. I used only dfn and tacit functions in my programs because they compose the most elegantly, together with [TryAPL](https://tryapl.org/) as a REPL to come up with answers one piece at a time. For example, to make a tacit function that checks if its input is a magic square:

With any nxn array,

```
      3 3⍴4 9 2 3 5 7 8 1 6
4 9 2
3 5 7
8 1 6
```

we can take its reverse and transpose,

```
      (⊂∘⍉,⊂∘⌽) 3 3⍴4 9 2 3 5 7 8 1 6
┌─────┬─────┐
│4 3 8│2 9 4│
│9 5 1│7 5 3│
│2 7 6│6 1 8│
└─────┴─────┘
```

concatenate their diagonals,

```
      ((⊢, 1 1∘⍉)¨(⊂∘⍉,⊂∘⌽)) 3 3⍴4 9 2 3 5 7 8 1 6
┌───────┬───────┐
│4 3 8 4│2 9 4 2│
│9 5 1 5│7 5 3 5│
│2 7 6 6│6 1 8 8│
└───────┴───────┘
```

remove their nesting,

```
      ((⊃,/)∘((⊢,1 1∘⍉)¨(⊂∘⍉,⊂∘⌽))) 3 3⍴4 9 2 3 5 7 8 1 6
4 3 8 4 2 9 4 2
9 5 1 5 7 5 3 5
2 7 6 6 6 1 8 8
```

sum their columns,

```
      ((+⌿)∘(⊃,/)∘((⊢,1 1∘⍉)¨(⊂∘⍉,⊂∘⌽))) 3 3⍴4 9 2 3 5 7 8 1 6
15 15 15 15 15 15 15 15
```

and check their equality,

```
      ((∧/⊃=⊢)∘(+⌿)∘(⊃,/)∘((⊢,1 1∘⍉)¨(⊂∘⍉,⊂∘⌽))) 3 3⍴4 9 2 3 5 7 8 1 6
1
```

which makes our final program `((∧/⊃=⊢)∘(+⌿)∘(⊃,/)∘((⊢,1 1∘⍉)¨(⊂∘⍉,⊂∘⌽)))`. That string alone still looks arcane to me, but broken down piece by piece it becomes much clearer, and remains shorter winded than [most other languages](https://www.geeksforgeeks.org/check-given-matrix-is-magic-square-or-not/).

# Result: Getting there!

[I placed third in Phase II](https://www.dyalog.com/news/146/420/2021-APL-Problem-Solving-Competition-Winners.htm) and took home bronze for the states, and I am looking forward to using what I learned to do better next year.
