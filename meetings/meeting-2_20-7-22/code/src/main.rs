use time;

// In this lesson we start looking at ownership and borrowing.
// Getting comfortable with the Borrow Checker in Rust is fundamental.
fn main() {
    
    let n = vec![1u64];

    // prints the borrowed n, does not consume it 
    dbg!(&n);
    dbg!(n);



    // prints the borrowed n and again does not consume it
    // borrow_number(&n);
    
    // prints the original n, after being moved and consumed
    // owned_number(n);

    // fails to compile because n was consumed and not returned
    // dbg!(&n);

}



fn borrow_number(borrowed: &Vec<u64>) {

  dbg!(borrowed);
}

fn owned_number(owned: Vec<u64>) {
  dbg!(owned);
}



#[test]
fn test_deref() {
    let x = &7;
    assert_eq!(*x, 7);

    let y = &mut 9;
    *y = 11;
    assert_eq!(y, &mut 11);
}