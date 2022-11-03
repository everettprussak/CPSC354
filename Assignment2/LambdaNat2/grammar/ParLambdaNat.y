-- -*- haskell -*- File generated by the BNF Converter (bnfc 2.9.4).

-- Parser definition for use with Happy
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
{-# LANGUAGE PatternSynonyms #-}

module ParLambdaNat
  ( happyError
  , myLexer
  , pProgram
  , pExp1
  , pExp2
  , pExp3
  , pExp4
  , pExp
  ) where

import Prelude

import qualified AbsLambdaNat
import LexLambdaNat

}

%name pProgram Program
%name pExp1 Exp1
%name pExp2 Exp2
%name pExp3 Exp3
%name pExp4 Exp4
%name pExp Exp
-- no lexer declaration
%monad { Err } { (>>=) } { return }
%tokentype {Token}
%token
  '('  { PT _ (TS _ 1)  }
  ')'  { PT _ (TS _ 2)  }
  '.'  { PT _ (TS _ 3)  }
  '0'  { PT _ (TS _ 4)  }
  'S'  { PT _ (TS _ 5)  }
  '\\' { PT _ (TS _ 6)  }
  L_Id { PT _ (T_Id $$) }

%%

Id :: { AbsLambdaNat.Id }
Id  : L_Id { AbsLambdaNat.Id $1 }

Program :: { AbsLambdaNat.Program }
Program : Exp { AbsLambdaNat.Prog $1 }

Exp1 :: { AbsLambdaNat.Exp }
Exp1 : '\\' Id '.' Exp { AbsLambdaNat.EAbs $2 $4 } | Exp2 { $1 }

Exp2 :: { AbsLambdaNat.Exp }
Exp2 : Exp2 Exp3 { AbsLambdaNat.EApp $1 $2 } | Exp3 { $1 }

Exp3 :: { AbsLambdaNat.Exp }
Exp3
  : '0' { AbsLambdaNat.ENat0 }
  | 'S' Exp3 { AbsLambdaNat.ENatS $2 }
  | Exp4 { $1 }

Exp4 :: { AbsLambdaNat.Exp }
Exp4 : Id { AbsLambdaNat.EVar $1 } | '(' Exp ')' { $2 }

Exp :: { AbsLambdaNat.Exp }
Exp : Exp1 { $1 }

{

type Err = Either String

happyError :: [Token] -> Err a
happyError ts = Left $
  "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ (prToken t) ++ "'"

myLexer :: String -> [Token]
myLexer = tokens

}

