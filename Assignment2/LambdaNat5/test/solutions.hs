-------------
--FUNCTIONS-- --Different names are okay if the prelude error exists; Similar to hw2 using the prebuild lists.
-------------

-------------
-- is_empty--
-------------

is_empty [] = 1
is_empty (x:xs) = if len (x:xs) > 0 then 0 else 1

-------------
-- LENGTH  --
-------------

len [] = 0
len (x:xs) = 1 + len xs

-------------
--   fib   --
-------------

fib 0 = 0
fib 1 = 1
fib n = fib(n-1) + fib(n-2)

-------------
--  even   --
-------------

even_a [] = 0
even_a (x:xs) = if (len (x:xs) `mod` 2) == 0 then 1 else 0

-------------
-- reverse --
-------------

-- Including Append --
append [] (y:ys) = if len(ys) > 0
    then
        y : append [] ys
    else
        [y]
append (x:xs) (y:ys) = x : append xs (y:ys)


revert [] = []
revert (x:xs) = append (revert xs) [x]


-------------
--  weave  --
-------------

weave [] [] = []
weave (x:xs) [] = (x:xs)
weave [] (y:ys) = (y:ys)
weave (x:xs) (y:ys) = if x < y
    then
        x : weave (xs) (y:ys)
    else
        y : weave (x:xs) (ys)


-------------
-- TESTING --
-------------
main = do
  print $ len [3,4,5] -- 3
  print $ len [2,3] -- 2

  print $ is_empty [] -- 1
  print $ is_empty [1,2,3] -- 0
  print $ is_empty [0] -- 0

  print $ fib 0 -- 0
  print $ fib 1 -- 1
  print $ fib 2 -- 1
  print $ fib 3 -- 2
  print $ fib 4 -- 3
  print $ fib 5 -- 5
  print $ fib 6 -- 8

  print $ even_a [] -- 0
  print $ even_a [1] -- 0
  print $ even_a [1,3] -- 1
  print $ even_a [2,4,6] -- 0
  print $ even_a [2,4] -- 1
  print $ even_a [4,5,3,5,6,4] -- 1

  print $ revert [2] -- [2]
  print $ revert [2,3,4] -- [4,3,2]
  print $ revert [5,2,4,6] -- [6,4,2,5]

  print $ weave [1] [] -- [1]
  print $ weave [1,2,3] [] -- [1,2,3]
  print $ weave [] [1] -- [1]
  print $ weave [] [1,2,3] -- [1,2,3]
  print $ weave [1,4,7] [2,3,8] -- [1,2,3,4,7,8]
  print $ weave [4,5,6] [1,2,3] -- [1,2,3,4,5,6]
  print $ weave [1,9,10] [2,3,4,5,6,7,8] -- [1,2,3,4,5,6,7,8,9,10]
