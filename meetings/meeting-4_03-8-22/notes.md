# Tool Scrubbers Guild Meeting # 4
Date: 03/08/22
Attendess(discord handles):
- @andersph 
- @Daniyal 
- @Kalvinen 
- @cj.blocz 
- @Nour | Bᴺ 𝕊pace
- @0D | 0o-de-lally 
- @thenateway 
- Wade | TPT
- @sirouk
- @Bilbobagwins
- @CPoP
- @Michael64
- @commstark
- @TheOneID
- @심영현

## Agenda

### Follow Up - Last Lesson

- Control Flow
- Borrow Checker
- Error Handling


### Resources
-  [Error Handling 1](https://doc.rust-lang.org/book/ch09-00-error-handling.html)
-  [Error Handling 2](https://www.sheshbabu.com/posts/rust-error-handling/)


### Agenda

- Recap
    - Error Handling
    - Borrow Checker
- Classes


### Other Items Covered

- Test driven development- refer to lesson 3 notes
- Error handling - refer to lesson 3 notes
- Correct usage of memory
    - difference between the heap and the stack
    - the concept of borrowing a reference to heap memory and storing a pointer in the stack to it.
    - How a vector works as a dynamic heap storage slot and then assigned a reference to it.
- Strings
    - Difference between str and string
    - String: a reference is stored on the stack to the dynamic memory allocated in the heap. Similar to a vector(I think a string is just a vector of chars abstracted)
    - str: is a immutable static reference in the stack 
- Memory: Sirouk presented his example question that he had run past OD last week. 
    - Question: how do we pass in variable to a different scope and are able to change it in that scope and the variable is returned to the original scope with the changes applied?
    - Answer: using `mut &`

    
### This Weeks Task
> Same as last week
- Find files within the `/ol` folder that have `.unwrap()` and add a match. Make sure these exit gracfully.
> For the adventurous look in `/cli/src/node` folder
- Find uses of `.clone()` and remove them. This may require refactoring of related files


### Outreach


### Video

https://youtu.be/7kLFWSxJvFA


