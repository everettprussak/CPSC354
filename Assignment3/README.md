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
### insert function notes:
### As we talked about in class, my list always starts with a variable list that points to null. Here is how to create the list variable and make it point towards null.
* val list = new [] ;;
* list := nil ;;
### Next if you want to insert an item into the empty list, this line can be done
* insert 4 list ;;
* insert 7 list ;;
* insert 1 list ;;
### The list we would have is [1,4,7] but to view it this line can be ran:
* print !list ;;
### Which will give us [1,4,7]
### The command given in the instructions:
* insert 3 (insert 1 (insert 4 (insert 2 (insert 5 nil)))) ;;
### Will not work in this order. It must be ran with this command instead:
* insert 3 (insert 1 (insert 4 (insert 2 (insert 5 list)))) ;;
### Simply, the address of the variable list (Typically address 1 if created right away) will be returned each time insert is ran, instead of the address of the value. This is because again my list looks like:
* list -> 1 -> 2 -> 3 -> 4 -> 5 -> null
### AND NOT:
* 1 -> 2 -> 3 -> 4 -> 5 -> null
### Despite this slight change, the insert method words as expected. Garbage Collection would be very beneficial for this assignment, due to the large amount of initialized variables, that will not be used again. If the list is not sorted, the number be inserted will go until a number that is larger than it. For example:
* print !list ;;
* [9,2,7]
* insert 5 list ;
* print !list ;;
* [5,9,2,7]
### This would be the output. Since 9 is larger than 5, it will simply just be placed right in front of it.

### sort function notes:
### Again, the list I created looks like:
* list -> 1 -> 2 -> 3 -> 4 -> 5 -> null
### This does not have much of an affect on sort. If a list is already sorted, and sort is used, it will stay sorted. If it is not sorted, then it will sort the list. Here is an example:
* print !list ;;
* [8,3,5,6] ;;
* sort list ;;
* print !list ;;
* [3,5,6,8] ;;
### As expected, this would be the result we want. This list can then use:
* insert n list ;;
### and the previous invariant will stay true. If you want to see the :env for sort, you will see many variables that got initialized and are not longer used. Again, garbage collection would be very good for this language, because without it a lot of memory is taken up.
### Lastly, the line in your instructions
* sort (cons 3 (cons 1 (cons 4 (cons 2 (cons 5 nil)))))
### Must be changed to:
* val list = new [] ;;
* list := (cons 3 (cons 1 (cons 4 (cons 2 (cons 5 nil))))) ;;
* sort list ;;
* print !list ;;
* [1,2,3,4,5]
### This is because of my addition of the variable. Slightly different context, but the same results.

### merge function notes:
### Similar to the other two functions, there is a slight change than what you might expect, but merge works as should. Here is how to get started on the function:
* val list1 = new [] ;;
* list1 := nil ;;
* val list2 = new [] ;;
* list2 := nil ;;
* merge list1 list2 ;;
### The merge function will give the address of list1. When merge happens, list2 elements are inserted into list1. This means that we are merging list2 into list1. However, if both lists are in order, the list1 that results will be sorted.
### Here is another example:
* val list1 = new [] ;;
* list1 := nil ;;
* val list2 = new [] ;;
* list2 := nil ;;
* insert 5 list1 ;;
* insert 3 list1 ;;
* insert 4 list1 ;;
* insert 1 list2 ;;
* insert 8 list2 ;;
* insert 4 list2 ;;
* merge list1 list2 ;;
* print !list1 ;;
* [1,3,4,4,5,8]
### As expected, the merge into list1 allows for the invariant to be true. If the lists are not sorted, list1 will still receive all of the elements from list2, but instead will not be sorted.

## Functions in Pseudo Code:
### Insert:
#### insert n list
####    if (list -> NULL):
####            value = new []
####             value -> [n, *list]
####             list -> value
####             return list
####
####    else:
####          current = new []
####          next = new []
####          value = new []
####          holding = new []
####          current -> *list
####          next -> head(tail(**list))
####          holding -> n
####          if n <= head(** current):
####                value -> [n,*current]
####                list -> value
####                return list
####
####          else:
####          while (*holding > head (** current)):
####                  if (**next == "NULL"):
####                      value -> [a,*next]
####                      *current -> [head ** current, value]
####                      holding -> head ** current
####
####                  else:
####                      if (*holding <= head (** current)):
####                          value -> [a,*next]
####                          *current -> [head ** current, value]
####                          holding -> head ** current
####
####                      else:
####                          current -> *next
####                          next -> head(tail(**next))
####
####                return list

### Sort:
#### two lines
#### two lines

## Interesting Thoughts
### Not Done
