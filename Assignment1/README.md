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
####  '\n'
#### multp (T (T (T I))) (T (T I)) = addP (multP (T (T I)) (T (T I))) (T (T I)) --> 4*3
#### multp (T (T I)) (T (T I)) = addP (addP (multP (T (T I)) (T (T I))) (T (T I))) (T (T I))
#### multp (T I) (T (T I)) = addP (addP (addP (multP (I) (T (T I))) (T (T I))) (T (T I))) (T (T I))
#### multp (T I) (T (T I)) = addP (addP (addP (T (T I)) (T (T I))) (T (T I))) (T (T I))
#### multp (T I) (T (T I)) = addP (addP (T (T (T (T (T I))))) (T (T I))) (T (T I))
#### multp (T I) (T (T I)) = addP (T (T (T (T (T (T (T (T I)))))))) (T (T I))
#### multp (T I) (T (T I)) = (T (T (T (T (T (T (T (T (T (T (T I)))))))))))  --> 12
####  
#### addI (II (S (S O)) (S O)) (II (S (S (S (S O)))) (O)) = II (addN (S (S O)) (S (S (S (S O)))) (addN (S O) (O))) --> 1 + 4
#### addI (II (S (S O)) (S O)) (II (S (S (S (S O)))) (O)) = II (S (S (S (S (S (S O)))))) (addN (S O) (O)))
#### addI (II (S (S O)) (S O)) (II (S (S (S (S O)))) (O)) = II (S (S (S (S (S (S O)))))) (S O)) --> 6-1 --> 5
####
#### negI (II (S (S O)) (S (S (S O)))) = II (addN (S (S (S O))) (O)) (addN (S (S O)) (O)) --> -1
#### negI (II (S (S O)) (S (S (S O)))) = II (S (S (S O))) (S (S O)) --> 1
####  
#### addQ (QQ (S O) (T (T I))) (QQ (S (S O)) (I)) = QQ (addI(multI (S O) (ii_pp (I))) (multI (ii_pp (T (T I))) (S (S O)))) (multP (T (T I)) (I)) --> 1/3 + 2/1
#### addQ (QQ (S O) (T (T I))) (QQ (S (S O)) (I)) = QQ (addI (multI (S O) (S O)) (multI ((S (S (S O)))) (S (S O)))) (multP (T (T I)) (I))
#### addQ (QQ (S O) (T (T I))) (QQ (S (S O)) (I)) = QQ (addI (S O) (multI (S (S (S O))))) (S (S O)))) (multP (T (T I)) (I))
#### addQ (QQ (S O) (T (T I))) (QQ (S (S O)) (I)) = QQ (addI (S O) (S (S (S (S (S (S O)))))) (multP (T (T I)) (I))
#### addQ (QQ (S O) (T (T I))) (QQ (S (S O)) (I)) = QQ (S (S (S (S (S (S (S O))))))) (multP (T (T I)) (I))
#### addQ (QQ (S O) (T (T I))) (QQ (S (S O)) (I)) = QQ (S (S (S (S (S (S (S O))))))) (T (T I)) --> 7/3 ~ 2.333

### Part 2