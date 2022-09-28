
#[tokio::main]
async fn main() {
  write_file(1);
  // do_delay(1);

  println!("hi");
  write_file(2).await;
  // do_delay(2).await;

  println!("hi again");
  // do_delay(3).await;
}



async fn do_delay(iter: u64) {
  use std::{thread, time};
  println!("start sleep: {}", iter);

  let ten_millis = time::Duration::from_millis(3_000);
  // let now = time::Instant::now();
  thread::sleep(ten_millis);

  println!("done sleeping");
  // assert!(now.elapsed() >= ten_millis);
}

// writes a file to the current directory asynchonously using tokio fs
async fn write_file(iter: u64) {
  use tokio::fs::File;
  use tokio::io::AsyncWriteExt;

  let filename = format!("foo-{}.txt", iter);
  let mut file = File::create(filename).await.unwrap();
  file.write_all(b"hello, world!").await.unwrap();
}
