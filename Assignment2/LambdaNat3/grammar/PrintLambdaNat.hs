-- File generated by the BNF Converter (bnfc 2.9.4).

{-# LANGUAGE CPP #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase #-}
#if __GLASGOW_HASKELL__ <= 708
{-# LANGUAGE OverlappingInstances #-}
#endif

-- | Pretty-printer for PrintLambdaNat.

module PrintLambdaNat where

import Prelude
  ( ($), (.)
  , Bool(..), (==), (<)
  , Int, Integer, Double, (+), (-), (*)
  , String, (++)
  , ShowS, showChar, showString
  , all, elem, foldr, id, map, null, replicate, shows, span
  )
import Data.Char ( Char, isSpace )
import qualified AbsLambdaNat

-- | The top-level printing method.

printTree :: Print a => a -> String
printTree = render . prt 0

type Doc = [ShowS] -> [ShowS]

doc :: ShowS -> Doc
doc = (:)

render :: Doc -> String
render d = rend 0 False (map ($ "") $ d []) ""
  where
  rend
    :: Int        -- ^ Indentation level.
    -> Bool       -- ^ Pending indentation to be output before next character?
    -> [String]
    -> ShowS
  rend i p = \case
      "["      :ts -> char '[' . rend i False ts
      "("      :ts -> char '(' . rend i False ts
      "{"      :ts -> onNewLine i     p . showChar   '{'  . new (i+1) ts
      "}" : ";":ts -> onNewLine (i-1) p . showString "};" . new (i-1) ts
      "}"      :ts -> onNewLine (i-1) p . showChar   '}'  . new (i-1) ts
      [";"]        -> char ';'
      ";"      :ts -> char ';' . new i ts
      t  : ts@(s:_) | closingOrPunctuation s
                   -> pending . showString t . rend i False ts
      t        :ts -> pending . space t      . rend i False ts
      []           -> id
    where
    -- Output character after pending indentation.
    char :: Char -> ShowS
    char c = pending . showChar c

    -- Output pending indentation.
    pending :: ShowS
    pending = if p then indent i else id

  -- Indentation (spaces) for given indentation level.
  indent :: Int -> ShowS
  indent i = replicateS (2*i) (showChar ' ')

  -- Continue rendering in new line with new indentation.
  new :: Int -> [String] -> ShowS
  new j ts = showChar '\n' . rend j True ts

  -- Make sure we are on a fresh line.
  onNewLine :: Int -> Bool -> ShowS
  onNewLine i p = (if p then id else showChar '\n') . indent i

  -- Separate given string from following text by a space (if needed).
  space :: String -> ShowS
  space t s =
    case (all isSpace t', null spc, null rest) of
      (True , _   , True ) -> []              -- remove trailing space
      (False, _   , True ) -> t'              -- remove trailing space
      (False, True, False) -> t' ++ ' ' : s   -- add space if none
      _                    -> t' ++ s
    where
      t'          = showString t []
      (spc, rest) = span isSpace s

  closingOrPunctuation :: String -> Bool
  closingOrPunctuation [c] = c `elem` closerOrPunct
  closingOrPunctuation _   = False

  closerOrPunct :: String
  closerOrPunct = ")],;"

parenth :: Doc -> Doc
parenth ss = doc (showChar '(') . ss . doc (showChar ')')

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id

concatD :: [Doc] -> Doc
concatD = foldr (.) id

replicateS :: Int -> ShowS -> ShowS
replicateS n f = concatS (replicate n f)

-- | The printer class does the job.

class Print a where
  prt :: Int -> a -> Doc

instance {-# OVERLAPPABLE #-} Print a => Print [a] where
  prt i = concatD . map (prt i)

instance Print Char where
  prt _ c = doc (showChar '\'' . mkEsc '\'' c . showChar '\'')

instance Print String where
  prt _ = printString

printString :: String -> Doc
printString s = doc (showChar '"' . concatS (map (mkEsc '"') s) . showChar '"')

mkEsc :: Char -> Char -> ShowS
mkEsc q = \case
  s | s == q -> showChar '\\' . showChar s
  '\\' -> showString "\\\\"
  '\n' -> showString "\\n"
  '\t' -> showString "\\t"
  s -> showChar s

prPrec :: Int -> Int -> Doc -> Doc
prPrec i j = if j < i then parenth else id

instance Print Integer where
  prt _ x = doc (shows x)

instance Print Double where
  prt _ x = doc (shows x)

instance Print AbsLambdaNat.Id where
  prt _ (AbsLambdaNat.Id i) = doc $ showString i
instance Print AbsLambdaNat.Program where
  prt i = \case
    AbsLambdaNat.Prog exp -> prPrec i 0 (concatD [prt 0 exp])

instance Print AbsLambdaNat.Exp where
  prt i = \case
    AbsLambdaNat.EAbs id_ exp -> prPrec i 1 (concatD [doc (showString "\\"), prt 0 id_, doc (showString "."), prt 0 exp])
    AbsLambdaNat.EIf exp1 exp2 exp3 exp4 -> prPrec i 2 (concatD [doc (showString "if"), prt 0 exp1, doc (showString "="), prt 0 exp2, doc (showString "then"), prt 0 exp3, doc (showString "else"), prt 0 exp4])
    AbsLambdaNat.ELet id_ exp1 exp2 -> prPrec i 2 (concatD [doc (showString "let"), prt 0 id_, doc (showString "="), prt 0 exp1, doc (showString "in"), prt 0 exp2])
    AbsLambdaNat.ERec id_ exp1 exp2 -> prPrec i 2 (concatD [doc (showString "let"), doc (showString "rec"), prt 0 id_, doc (showString "="), prt 0 exp1, doc (showString "in"), prt 0 exp2])
    AbsLambdaNat.EMinusOne exp -> prPrec i 2 (concatD [doc (showString "minus_one"), prt 0 exp])
    AbsLambdaNat.EApp exp1 exp2 -> prPrec i 3 (concatD [prt 3 exp1, prt 4 exp2])
    AbsLambdaNat.ENat0 -> prPrec i 4 (concatD [doc (showString "0")])
    AbsLambdaNat.ENatS exp -> prPrec i 4 (concatD [doc (showString "S"), prt 4 exp])
    AbsLambdaNat.EVar id_ -> prPrec i 5 (concatD [prt 0 id_])
    AbsLambdaNat.EFix exp -> prPrec i 2 (concatD [doc (showString "fix"), prt 0 exp])
