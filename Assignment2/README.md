# Information
## Everett Prussak
## prussak@chapman.edu
## 2368093
## CPSC 354
## Assignment 2
## Professor Kurz
## November 18th, 2022

# Critical Apprasial
## Comments for Professor Kurz
### Task 1 works, and many examples are given in mytests.lc
### For Task 2, when running ./LambdaNat-exe test/solutions.lc, it will take 20-40 seconds due to amount of examples and complexity of reverse specifically.
### For task 2, all of the functions run to my knowledge. I have not found an example where It does not work the way it should, as long as the input is correctly formatted.
### For weave, if the two lists being weaved through are not sorted, then it will simply just append list b to the end of list a.
### Task 3 works to my knowledge. There are many examples in the main.
## Questions
### For example, #:# does not parse, but (#):# does. Why? Does that mean that it would make sense to change the grammar?
### #:# does not parse because because it does not follow the grammar rules we made. # is for the end of a list, and # at the start would not make any sense. (#):# works because of the parenthesis. These parenthesis are telling us that the first # is the end of the () list, but # on the outside at the end is the end of the entire list. We can have lists within lists.
### I found this assignment very interesting. It was really cool to make "my own" coding language. Using a parser, interpreter, then actually creating functions in solutions.lc was interesting experience. The overall task was hard at first, but part by part actually made it quite enjoyable to complete and see it work. Building an entire programming language has many parts as we learned this year, but I am interested as to pros and cons of using haskell as the interpreter versus other coding languages such as C++, java, python, and others. What is the main reason haskell is so good compared to these languages? Recursion? No-variables? I am interested, so please let me know the main reasoning for this.
## Discuss The Following
### Explain what changes where made in LambdaNat4 in order to accommodate multiple test cases (separated by ;;) in the same file.
### In LambdaNat4, a change was made to LambdaNat4.cf in terms of the grammar to allow for ;; to be used for separation. In line 6, we have separator Exp ";;" ;. This tells us that each expression will be executed, then followed by ;; to end it. Thus having ;; clearly separated each function/program from each other.
### Reflect on the differences between LambdaNat5 and the Calculator. In LambdaNat5, why can't we implement arithmetic using the simple
### One difference I noticed was in the two Interpreters. In assignment 1, the interpreter had this line "eval :: Exp -> Integer", while in assignment 2 it has a line like this "evalCBN :: Exp -> Exp". Assignment 1, we are automatically going from exp to an integer. However in Assignment 2, we have an expression to an expression. This is a huge reason why we can use the simple arithmetic simples +,-,*,'div' in assignment 1 and not assignment 2. Since we know that we are going to end with an Integer, we know that the two numbers can do this type of arithmetic based on data-types already existing in haskell. However, we cannot use +,-,etc in assignmet 2 because exp is not a data-type that can necessarily do it by itself. We have to program EPlus, EMinus, and ETimes to do the correct arithmetic based on our data-types and other factors. We cannot simply use the already created/made arithmetic, which makes the building of a new programming language that much more interesting. +,-,etc are implemented by value in assignment 1, but name in assignment 2 once they are made. The reason is due to the same as above, of exp versus integer data-type.
### Reflect on the differences between LambdaNat5 and Haskell. In your experience from this assignment, how does writing code in LambdaNat5 and Haskell compare? How far did we come in implementing a functional programming language? What is missing? What can you say about how one should go about extending LambdaNat5 to a more powerful functional language (such as Haskell)?
### LambdaNat5 and Haskell compare by using a lot of recurssion and not having variable names. They both use functions and use recursion many times to get the correct answer. I think we came a decent way for implementing a functional programming language, but there are many other things that would have to be done. Many error checkings, strings, and many more methods and functions would have to be created to allow for this language to practical use in my opinion. Also making it easier to run would allow for more users to have a more simple time using it. I think string manipulation would be very beneficical. We have lists right now, which strings are basically a list of characters, but it would have to more funtions to look like a string rather than a list of characters. There also has to be index for each character/integer in a list. I think it would be good to have a list of just characters, or just integers, rather than mixing them. I think extending the grammar would be the first step, then the interpreter, then the functions. The first two steps are the "core" of the language, so the more the merrier. Simple things must be added to allow for more flexibility in the language.
### Did you notice that weave satisfies the invariant "the output-list is sorted if the input-lists are sorted"? Can you use it to prove the correctness of sort (that is, that sort actually does sort)?
### Yes, you could use to prove sort. If the weave of two lists do end up being sorted, then you know that the original two lists were indeed sorted. If the weave of two lists is not sorted, then you know that one of the lists was not sorted at best.
