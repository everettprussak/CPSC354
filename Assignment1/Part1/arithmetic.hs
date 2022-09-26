-- A Virtual Machine (VM) for Arithmetic (template)
-- Copyright: Alexander Kurz 2022

-----------------------
-- Data types of the VM
-----------------------

-- Natural numbers
data NN = O | S NN
  deriving (Eq,Show) -- for equality and printing

-- Integers
data II = II NN NN
  deriving (Show) -- for equality and printing

-- Positive integers (to avoid dividing by 0)
data PP = I | T PP
  deriving (Show)
-- Rational numbers
data QQ =  QQ II PP
  deriving (Show)

------------------------
-- Arithmetic on the  VM
------------------------

----------------
-- PP Arithmetic
----------------
addP :: PP -> PP -> PP
addP I x = T (x)
addP (T y) x = T (addP y x)

multP :: PP -> PP -> PP
multP I x = x
multP (T y) x = addP (multP y x) x

----------------
-- NN Arithmetic
----------------

-- add natural numbers
addN :: NN -> NN -> NN
addN O m = m
addN (S n) m = S (addN n m)

-- multiply natural numbers
multN :: NN -> NN -> NN
multN O m = O
multN (S n) m = addN (multN n m) m


subN :: NN -> NN -> NN
subN a O = a
subN O b = O
subN (S a) (S b) = subN (a) (b)

--division
divN :: NN -> PP -> NN
divN O b = O
divN a I = a
divN (a) (b) = addN(divN (subN (a) (nn_pp(b))) (b)) (if (subN (a) (nn_pp (b)) == (O) && (a) /= (nn_pp (b))) then (O) else (S O))
--Have to fix 1/2 = 0 not 1

--remanider
modN :: NN -> PP -> NN
modN O b = O
modN a b = subN (a) (multN (nn_pp(b)) (divN (a) (b)))
----------------
-- II Arithmetic
----------------
addI :: II -> II -> II
addI (II a b) (II c d) = II (addN a c) (addN b d) 


multI :: II -> II -> II
multI (II a b) (II c d) = II (addN(multN a c) (multN b d)) (addN(multN a d) (multN b c))

negI :: II -> II
negI (II a b) = II (addN b O) (addN O a)

-- Equality of integers
--instance Eq II where
  --(II a b) == (II c d) = (if (subN(a b) == subN(c d)) then True else False)


----------------
-- QQ Arithmetic
----------------

-- Addition: (a/b)+(c/d)=(ad+bc)/(bd)
addQ ::QQ -> QQ -> QQ
addQ (QQ a b) (QQ c d) = QQ (addI(multI a (ii_pp d))(multI (ii_pp b) c)) (multP b d)

-- Multiplication: (a/b)*(c/d)=(ac)/(bd)
multQ :: QQ -> QQ -> QQ
multQ (QQ a b) (QQ c d) = QQ (multI a c) (multP b d)

-- Equality of fractions
--instance Eq QQ where
  --(QQ a b) == (QQ c d) = <insert your code here>

----------------
-- Normalisation
----------------

nbe :: II -> II
nbe (II (a) (O)) = II (a) (O)
nbe (II (O) (b)) = II (O) (b)
nbe (II (S a) (S b)) = (nbe (II (a) (b)))

----------------------------------------------------
-- Converting between VM-numbers and Haskell-numbers
----------------------------------------------------

-- convert numbers of type PP to numbers of type II
ii_pp :: PP -> II
ii_pp I = II (S O) (O)
ii_pp (T y) = II (S (nn_pp y)) (O)

-- convert numbers of type PP to numbers of type NN
nn_pp :: PP -> NN
nn_pp I = (S O)
nn_pp (T x) = S(nn_pp x)


-- Precondition: Inputs are non-negative
nn_int :: Integer -> NN
nn_int 0 = O
nn_int 1 = (S O)
nn_int a = S (nn_int (a-1))

--NN to Integer
int_nn :: NN->Integer
int_nn O = 0
int_nn (S O) = 1
int_nn (S m) = 1 + (int_nn(m))

--Integer to II
ii_int :: Integer -> II
ii_int 0 = II (O) (O)
ii_int 1 = II (S O) (O)
ii_int a = II (nn_int (a)) (O)

--II to Integer
int_ii :: II -> Integer
int_ii (II (O) (O)) = 0
int_ii (II (S O) (O)) = 1
int_ii (II a b) = int_nn(a) - int_nn(b)

-- Precondition: Inputs are positive
pp_int :: Integer -> PP
pp_int 1 = I 
pp_int 2 = (T I)
pp_int a = (T (pp_int(a-1)))

int_pp :: PP->Integer
int_pp I = 1
int_pp (T I) = 2
int_pp (T x) = 1 + int_pp(x)

----------
-- Testing
----------
main = do
    print $ addN (S (S O)) (S O) -- S (S (S O))
    print $ multN (S (S O)) (S (S (S O))) -- S (S (S (S (S (S O)))))
    print $ addI (II (S (S O)) (S( S O))) (II (S (S (S O))) (S (S O)))
    print $ multI (II (S (S (S (S O)))) (S( S O))) (II (S (S (S O))) (S (S O)))
    print $ negI (II (S (S O)) (S (S (S (S O)))))
    print $ addP (T I) (T I) -- 2 + 2 = 4 which is T (T (T I))
    print $ addP (T I) (I)
    print $ multP (T I) (T (T I)) -- 2*3 = 6 which is T (T (T (T (T I))))
    print $ ii_pp (T I)
    print $ addI (II (S O) (O)) (II (S O) (S O))
    print $ nn_pp (I)
    print $ nn_pp (T (T I))
    print $ ii_pp (T (T (T I)))
    print $ addQ (QQ (II (S (S (S (S (S O))))) (S (S O))) (T I)) (QQ (II (S (S (S (S (S O))))) (S (S (S O)))) (T I))
    print $ addQ (QQ (II (S (S O)) (O)) (T I)) (QQ (II (S O) (O)) (T I))
    print $ multQ (QQ (II (S (S O)) (O)) (T I)) (QQ (II (S O) (O)) (T I))
   -- print $ (II (S O) (S O)) == (II (S O) (O))
    print $ nn_int 0
    print $ nn_int 1
    print $ nn_int 2
    print $ int_nn O
    print $ int_nn (S O)
    print $ int_nn (S (S (S O)))
    print $ ii_int 4
    print $ int_ii (II (O) (O))
    print $ int_ii (II (S (S (S O))) (O))
    print $ pp_int 2
    print $ pp_int 5
    print $ int_pp (T (T (T (T I))))
    print $ int_nn (multN (nn_int 4) (nn_int 3)) -- 12
    print $ int_nn (divN (nn_int 6) (pp_int 3)) -- 2
    print $ int_nn (divN (nn_int 9) (pp_int 3)) -- 3
    print $ int_nn (divN (nn_int 13) (pp_int 5)) -- 2
    print $ int_nn (divN (nn_int 1) (pp_int 2)) -- 0
    print $ nbe (II (S (S O)) (S (S (S O))))
    print $ int_nn (subN (nn_int 9) (nn_int 3)) -- 6
    print $ int_nn (subN (nn_int 11) (nn_int 12)) -- 0
   -- print $ (II (S O) (O)) == (II (S O) (S O))
    print $ int_nn (modN (nn_int 13) (pp_int 5)) --3
    print $ int_nn (modN (nn_int 14) (pp_int 4)) --2