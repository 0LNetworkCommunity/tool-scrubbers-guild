use std::{fmt::Error, io, process::exit};
use time;

// This lesson is about STructs. Similar to classes in other languages.
// Structs are like classes, but they are not inherited.
// see files impl.rs and traits.rs for examples of methods and traits.

fn main() {
  // let's do simple instantiation of a struct.
  let c = get_car();
  dbg!(&c);

  // lets send a Car into a function and get a new one out
  let new_car = change_car(c);
  dbg!(&new_car);
}

struct Car {
    name: String,
    year: i32,
    color: String,
}


fn get_car() -> Car {
    Car {
        name: "Volvo".to_string(),
        year: 2019,
        color: "red".to_string(),
    }
}

fn change_car(old_car: Car) -> Car {
    Car {
        name: old_car.name,
        year: 2022,
        color: "blue".to_string(),
    }
}

