

#[tokio::main]
async fn main() {
  do_delay().await;
}



async fn do_delay() {
use std::{thread, time};
println!("start sleep");
let ten_millis = time::Duration::from_millis(3_000);
let now = time::Instant::now();

thread::sleep(ten_millis);
println!("done sleeping");
assert!(now.elapsed() >= ten_millis);
}