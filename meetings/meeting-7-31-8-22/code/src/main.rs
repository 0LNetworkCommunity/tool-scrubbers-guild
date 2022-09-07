use anyhow::{ self, bail};

fn main() {
  println!("starting app");

  match another_outer() {
    Ok(s) => println!("my string: {}", s),
    Err(e) => {
      // dbg!(&e)
      println!("{:?}", &e);
    },
  }

}

fn another_outer() -> Result<String, anyhow::Error> {
  // let a = match inner() {
  //   Ok(s) => {
  //     format!("change this to: {}", s)
  //   },
  //   Err(e) => {
  //     // dbg!(&e)
  //     println!("{:?}", &e.source());
  //     return Err(e);
  //   }
  // };

  let a = inner()?;

  Ok(format!("change this to: {}", a))
}


// fn outer() -> Result<String, anyhow::Error> {
//   inner()
// }

fn inner() -> Result<String, anyhow::Error> {
  if true {
    // let a = anyhow::anyhow!("you made this true");
    // return Err(a);
    bail!("you made this true");
  }

  Ok("This is good".to_string())
}
