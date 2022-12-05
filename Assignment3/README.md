# Information
### Everett Prussak
### prussak@chapman.edu
### 2368093
### CPSC 354
### Assignment 3
### Professor Kurz
### Part 1: 12/4/2022
### Part 2: 12/11/2022


# Critical Apprasial
## Information about Part 1:
### For part 1, I changed the name of the function "is_empty" to "isEmpty". I was getting an error due to the underscore, so I decided that this was the best name change for it. All of the other functions work as you would expect. isEmpty will give a 1 if the list is empty, and a 0 if the list is not empty. Fib will calculate the fibonacci of a number, assuming that that number is a positive whole number. length will calculate the length of a list. even will return 1 if the list is even, and 0 if it is not. An empty is list will be considered "not even" so a 0 will be returned. Append will append the second list to the back of the first list. reverse will reverse the list. Weave will weave a list in order, IF the lists are already in order. If they are not in order, and weave is used, the lists will be combined, but not in order and not similar to just appending to the end.

## Information about Part 2:
### insert function notes: The invariant stays true in my function, as when you insert into a sorted list, the list stays sorted after the insertion. When inserted, the address of the FIRST ELEMENT of the list is returned. For example for the list [4,5,6], the address of element 4 will be returned. That means if the list is sorted, then the smallest elemenets address will be returned. When starting the program, these must be ran in LamFun.
* val list = new [] ;;
* list := nil ;;
* insert 4 list ;;
### Then insert 2 list ;; can be ran, or by creating a new variables: val a = new [];; a := [4,nil];; then list := a;; insert 2 list ;; can then be ran also. Insert uses a little more initialization of variables than I would have liked. If the list is not empty and something is being inserted, I create a current, next, value, and aValue.  Current and next allow me to keep track of where I am on the linkedList. value is used to create a address for the value that is being inserted. aValue is counter that allows me to exit the loop when I need to. I wanted to make this better, but as of now I have not found something without getting errors. I understand that initializing another variable is not the best in terms of memory efficiency. I have not found any errors in insert, but it must be done in the way I previously stated. Assuming that the command val list = new [] ;; is ran first, list should be address 0, so simply it can followed that way instead of looking at the first value address returned as well.

###sort function notes: Sort works as it should. When sort list ;; is ran, it will sort the function as expected. When you look in the environment (:env), and you follow your list addresses, you will see that it is in sorted order. However, again many things are initialized which decreases performance, but it does as it is supposed to without errors.

## Interesting Thoughts
### Not Done
