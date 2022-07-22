use time;
fn main() {
    
    let n = vec![1u64];

    // prints the borrowed n, does not consume it 
    dbg!(&n);

    // prints the borrowed n and again does not consume it
    borrow_number(&n);
    
    // prints the original n, after being moved and consumed
    owned_number(n);
    // fails because n was consumed and not returned
    dbg!(&n);

    let my_year = get_time_res();

    match my_year {
        Ok(r) => println!("match found something: {}", r),
        Err(e) => println!("ERROR: {}", e),
    }
    if let Some(y) = my_year {
      println!("found something");
      dbg!(&y);
    } else {
      println!("nothing found");
    }

    match my_year {
        Some(w) => println!("match found something: {}", w),
        None => println!("match found NONE"),
    }

    dbg!(&my_year.is_some()); 
    my_year.
    dbg!(&my_year.unwrap());
    

    dbg!(&my_year);

}

fn borrow_number(borrowed: &Vec<u64>) {

  dbg!(borrowed);
}

fn owned_number(owned: Vec<u64>) {
  dbg!(owned);
}

fn get_time() -> Option<i64> {
  let t = time::now_utc();
  if true {
    let year = t.tm_year as i64;
    return Some(year)
  }
  return None
}

fn get_time_res() -> Result<i64, String> {
  let t = time::now_utc();
  if true {
    let year = t.tm_year as i64;
    return Ok(year)
  }
  return Err("oops there's an error".to_string())
}
