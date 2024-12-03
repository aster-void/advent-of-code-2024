use rust::{read_file, step2};

fn main() {
    let args = std::env::args().collect::<Vec<_>>();
    let path = args
        .get(1)
        .expect("Expected an argument. e.g. `cargo run --bin step2 inputs/test.txt`");
    let input = read_file(path);

    println!("{}", step2(input));
}
