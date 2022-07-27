# Tool Scrubbers Guild Meeting # 2
Date: 20/07/22
Attendess(discord handles):
- @andersph 
- @Daniyal 
- @Kalvinen 
- @cj.blocz 
- @mortonbits
- @Saturn 
- @Nour | Bᴺ 𝕊pace
- @0D | 0o-de-lally 
- @thenateway 
- @Wade | TPT
- @0xslipk
- @sirouk
- @TheOneID 

## Agenda

### Housekeeping

- Make sure everyone adds their address before EOM to get paid
- All information regarding Tool Scrubbers can be found in this repo
- A new project board and issues have been created to help with work

### Follow Up - Last Lesson - Quetions

- Why are we using the rust version 1.61.0 in Diem?
    - Because it is a large complex collection of programs
    - Initially when 0L libra repo was forked it was using nightly for the first year
    - Not sure about Aptos and what version they are using after the changes

- Is unwrap bad to use and what is the best way to handle errors?
    - We want to exit, not panic so it is best to use result
    - using `exit()` with error code is the graceful way to do it eg `exit(1)`

- How to use strings in rust?
    - We will cover in another lesson

### Resources
-  [Option](https://doc.rust-lang.org/rust-by-example/std/option.html)
-  [Result](https://doc.rust-lang.org/rust-by-example/error/result.html)
-  [Unit Testing](https://doc.rust-lang.org/rust-by-example/testing/unit_testing.html)
-  [Testing](https://doc.rust-lang.org/rust-by-example/cargo/test.html)
-  [Borrow Checker Video](https://www.youtube.com/watch?v=u4KyvRGKpuI)
-  [Borrow Checker Article](https://blog.logrocket.com/introducing-the-rust-borrow-checker/)

### Agenda

- Recap
    - Borrow checker
    - Option
    - Result
- Testing
    - Annotate with `[test]`
    - Annotate is also called pragma in other languages
    - `cargo t` - runs tests
    - Can import functions within a file and use in the tests
    - within tests use `assert()` and `assert_eq()`
    - tests can go into the same file or in another folder usually called tests in the root of the program
    - All private functions must have their tests within the same file
    - Functional test can be in the test folder

### Other Items Covered Briefly

- Lifetimes - Advanced - Will cover in depth in the future 


### This Weeks Task
- Find files within the `/ol` folder that have `.unwrap()` and add a match. Make sure these exit gracfully.
> For the adventurous look in `/cli/src/node` folder
- Find uses of `.clone()` and remove them. This may require refactoring of related files


### Outreach

### Video

