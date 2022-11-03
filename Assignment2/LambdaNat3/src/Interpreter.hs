module Interpreter ( execCBN ) where

import AbsLambdaNat -- provides the interface with the grammar and is automatically generated by bnfc
import ErrM
import PrintLambdaNat

-- execCBN is a function from type Program to type Exp, calling evalCBN
-- CBN is short for Call By Name, see the lectures
-- the types Program and Exp are defined in AbsLambdaNat.hs
execCBN :: Program -> Exp
execCBN (Prog e) = evalCBN e
-- evalCBN is the actual interpreter
evalCBN :: Exp -> Exp
-- in lambda calculus everything is an expression, whether input, program or output
-- this interpreter only has one computation rule: the beta-reduction of lambda calculus
-- it uses the substitution function defined in class and also in Haskell below
evalCBN (EApp e1 e2) = case (evalCBN e1) of
    (EAbs i e3) -> evalCBN (subst i e2 e3)
    e3 -> EApp e3 e2

-- My Code--
evalCBN ENat0 = ENat0
evalCBN (ENatS e) = ENatS (evalCBN e)

--Part 1
evalCBN (EIf a b c d) = if (evalCBN a) == (evalCBN b) then evalCBN c else  evalCBN d
evalCBN (ELet i a b) =  evalCBN (EApp (EAbs i b) a)
evalCBN (EMinusOne e) = case (evalCBN e) of
    ENat0 -> ENat0
    (ENatS e) -> e
----------------------------------------------------
--- YOUR CODE goes here for extending the interpreter
----------------------------------------------------
evalCBN x = x -- this is a catch-all clause, must be the last clause of the eval function

-- fresh generates fresh names for substitutions, can be ignored for now
-- a quick and dirty way of getting fresh names. Rather inefficient for big terms...
fresh_aux :: Exp -> String
fresh_aux (EVar (Id i)) = i ++ "0"
fresh_aux (EApp e1 e2) = fresh_aux e1 ++ fresh_aux e2
fresh_aux (EAbs (Id i) e) = i ++ fresh_aux e
fresh_aux _ = "0"

fresh = Id . fresh_aux -- for Id see AbsLamdaNat.hs

-- subst implements the beta rule
-- (\x.e)e' reduces to subst x e' e
subst :: Id -> Exp -> Exp -> Exp
subst id s (EVar id1) | id == id1 = s
                      | otherwise = EVar id1
subst id s (EApp e1 e2) = EApp (subst id s e1) (subst id s e2)
subst id s (EAbs id1 e1) =
    -- To avoid variable capture, we first substitute id1 with a fresh name inside the body of the λ-abstraction, obtaining e2.
    -- Only then do we proceed to apply substitution of the original s for id in the body e2.
    let f = fresh (EAbs id1 e1)
        e2 = subst id1 (EVar f) e1 in
        EAbs f (subst id s e2)


----------------------------------------------------------------
--- YOUR CODE goes here if subst needs to be extended as well
----------------------------------------------------------------

subst id s ENat0 = ENat0
subst id s (ENatS e) = ENatS (subst id s e)

--Part 1 SUBST code--
subst id s (EIf a b c d) = EIf (subst id s a) (subst id s b) (subst id s c) (subst id s d)

--subst id s (ELet i a b) = ELet (subst id s (EAbs (i b))) (subst id s a)
subst id s (ELet i a b) = ELet i (subst id s a) (subst id s b)

subst id s (EMinusOne e) = EMinusOne (subst id s (ENatS e))
