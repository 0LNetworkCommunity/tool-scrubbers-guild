use std::{fmt::Error, io, process::exit};
use time;


// Rust does not have Class inheritance.
// The pattern for reusability leverages construction instead of inheritance.
// Traits are the way to define the methods that a struct can use. Similar to the "interfaces" of a class in other languages.

#[test] 
fn test_vehicle_trait() {
    let c = Car::new("Volvo".to_string(), 2019, "Red".to_string());
    dbg!(&c);
    let b = Boat::new("Boat".to_string(), 2014, "Blue".to_string());
    dbg!(&b);

}


// For example all the vehicles may have similar "traits", and we can enforce what methods they use with the "trait bounds".
// Here we keep it simple, every vehicle, has a function "new" which in it's signature returns the types new_name, new_year, new_color, and should return the Self of the struct.
trait VehicleTrait {
  fn new(new_name: String, new_year: i32, new_color: String) -> Self;  
}


#[derive(Debug)]
struct Car {
    name: String,
    year: i32,
    color: String,
}


#[derive(Debug)]
struct Boat {
    name: String,
    year: i32,
    color: String,
}


// to implement the methods of the trait for car, we use the `impl` keyword, only slightly dferent from an impl that doesn't have "trait bounds".
impl VehicleTrait for Car {
  fn new(new_name: String, new_year: i32, new_color: String) -> Self {
    Car {
      name: new_name,
      year: new_year,
      color: new_color,
    }
  }
}

impl VehicleTrait for Boat {
  fn new(new_name: String, new_year: i32, new_color: String) -> Self {
    Boat {
      name: new_name,
      year: new_year,
      color: new_color,
    }
  }
}