use time;

// In this lesson we start with control flow.
// We need to understand the different ways to handle errors, and how to safely exit a program.
fn main() {


    // let time = get_time();
    // dbg!(&time);

    // so we can handle the option with a match statement.
    // match time {
    //     Some(w) => println!("match found something: {}", w),
    //     None => println!("match found NONE"),
    // }





    // // or use a dereference operator to get the value out of the option.
    // // this may not appear intuitive, but it's a very common pattern you will see in rust code.
    // if let Some(y) = my_year {
    //   println!("found something");
    //   dbg!(&y);
    // } else {
    //   println!("nothing found");
    // }


    // // Let's look at Result types.

    // let my_year = get_time_res();

    // Result types allow us do do more with Error types (which we'll learn in future lessons)
    // let my_year = get_time_res();
    // match my_year {
    //     Ok(r) => println!("match found something: {}", r),
    //     Err(e) => println!("ERROR: {}", e),
    // }
    

    // Using different variants of unwrap methods:
    
    // let a = get_time_res().unwrap_or(42);
    // dbg!(&a);

    // let a = get_time_res().unwrap_or_else(
    //   |e| {
    //     // do whatever
    //     77
    //   }
    // );
    // // is equivalent to:
    // let a = match get_time_res() {
    //   Ok(a) => a,
    //   Err(e) => { 77 }
    // };

    // dbg!(&a);
}


// the Option enum type is used for when we may not find data that's needed
fn get_time() -> Option<i64> {
  let t = time::now_utc();
  if false {
    let year = t.tm_year as i64;
    return Some(year)
  }
  return None
}

// the Result enum type is a variant of Option that can have two different types for Ok and Err variants.

fn get_time_res() -> Result<i64, String> {
  let t = time::now_utc();
  if false {
    let year = t.tm_year as i64;
    return Ok(year)
  }
  return Err("oops there's an error".to_string())
}
