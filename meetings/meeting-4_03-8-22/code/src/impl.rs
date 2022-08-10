use std::{fmt::Error, io, process::exit};
use time;

// instead of keeping functions in your file which create and return a struct,
// you can use methods to "construct" the struct, or modify.

#[test] 
fn test_change_car() {
    let mut c = Car::new("Volvo".to_string(), 2019, "Red".to_string());
    c.change_car(2020);
    assert_eq!(c.year, 2020);
}

#[derive(Debug)]
struct Car {
    name: String,
    year: i32,
    color: String,
}


impl Car {
    // construct explicitly
    fn new(new_name: String, new_year: i32, new_color: String) -> Self {
        Self {
            name: new_name,
            year: new_year,
            color: new_color,
        }
    }

    // create a default
    fn my_default() -> Self {
        Self {
            name: "Volvo".to_string(),
            year: 1996,
            color: "Red".to_string(),
        }
    }

    // this is a naive way of taking a struct and changing it.
    // here you are returning a new struct
    // repeating this will create memory leaks.
    fn change_car_gross(self, new_year: i32) -> Car {
        Car {
            name: self.name,
            year: new_year,
            color: self.color,
        }
    }

    // instead, you can modify the struct in place.
    fn change_car(&mut self, new_year: i32) {
        self.year = new_year;
    }
}

