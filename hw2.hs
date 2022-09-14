doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y
doubleSmallNumber x = if x > 100
    then x 
    else x*2

len [] = 0
len (x:xs) = 1 + len xs

member y (x:xs) = if y==x
    then True
    else if len(xs) < 1
        then False
        else member y xs

append [] (y:ys) = if len(ys) > 0
    then 
        y : append [] ys
    else
        [y] 
append (x:xs) (y:ys) = x : append xs (y:ys)

revert [] = []
revert (x:xs) = append (revert xs) [x]

less_equal [] [] = True
less_equal (x:xs) (y:ys) = if x<=y
    then 
        less_equal xs ys
    else
        False

select_evens [] = []
select_evens (x:xs) = select_odds xs

select_odds (x:xs) = x : select_evens xs
select_odds [] = []

