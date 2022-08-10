use std::{fmt::Error, io, process::exit};
use time;

// More advanced cases of Ownership and Borrows
// dereferncing and completely overwriting memory on the heap

fn main() {
  let mut v = vec![1];
  println!("original: {:?}", &v);
  number_frier(&mut v);
  println!("fried: {:?}", &v);
}

// you must "destructure" the reference to the Vec, with the "*" operator
// the Vec needs to be mutable in order to access the underlying memory, and modify it
fn number_frier(borrow: &mut Vec<u64>) {

  let mut hello:  Vec<u64> = Vec::new();
  hello.push(100u64);

  *borrow = hello;

}
