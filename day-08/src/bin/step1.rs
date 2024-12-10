use day8::{read_file, step1};

fn main() {
    let args = std::env::args().collect::<Vec<_>>();
    let path = args
        .get(1)
        .expect("Expected an argument. e.g. `cargo run --bin step1 inputs/test.txt`");
    let input = read_file(path);

    println!("{}", step1(input));
}
