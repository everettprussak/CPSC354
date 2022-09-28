module Interpreter where

import AbsNumbers

eval :: Exp -> Integer
eval (Num n) = n
eval (Plus n m) = (eval n) + (eval m)
eval (Times n m) = (eval n) * (eval m)

--My Code
eval (Subtract n m) = (eval n) - (eval m)
eval (Divide n m) = (eval n) `div` (eval m)
eval (Exponent n m) = (eval n) ^ (eval m)

eval (Squared n) = (eval (Exponent (n) (Num 2)))

eval (AbsValue n) = (if (eval n) < 0 then (eval (Times (n) (Negative (Num 1)))) else (eval n))

eval (Negative n) = 0 - (eval n)

-- Need to do Factorial and Create another one