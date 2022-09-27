# Everett Prussak
## prussak@chapman.edu
## CPSC 354
## Professor Kurz
## Assignment1

## Critical Appraisal
### Part 1
#### I implemented everything that you asked for. Everything works the way I believe you would want it to work.
#### I learned a lot in this assignment, especially Part 1. At first, I was very confused on how to implement each function. However, as I got more use to the syntax and grew to learn Haskell and Pattern Matching even more, I found it much easier. I think DivN was the function that took the longest. I created SubN, which was not required, but could not figure out a DivN solution without it. Pattern Matching is a very interesting process. I found it very satisfy to write code that ran correctly, and grew to actually like this style of programming. I think Pattern matching is a very essential tool, and this part of the assignement allowed me to understand it. I also really liked createing "new" data-types of our own. Creating functions that would be my own creation was also a cool idea.
#### Equational Reasoning
#### addP (T (T (T I))) (T (T I)) = T (addP (T (T I)) (T (T I))) --> 4+3
#### addP (T (T I)) (T (T I)) = T (T (addP (T I) (T (T I))))
#### addP (T I) (T (T I)) = T (T (T(addP (I) (T (T I)))))
#### addP (I) (T (T I)) = T (T (T (T (T (T I))))) --> 7
####
#### multP :: PP -> PP -> PP
#### multP I x = x
#### multP (T y) x = addP (multP y x) x
### Part 2