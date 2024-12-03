pub fn step1(input: String) -> usize {
    input.chars().filter(|&char| char == 'o').count()
}
pub fn step2(input: String) -> usize {
    todo!()
}

pub fn read_file(path: &str) -> String {
    let buf = std::fs::read(path).expect("File not found");
    String::from_utf8(buf).expect("Failed to parse file as utf8")
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_step1() {
        let input = read_file("inputs/test.txt");
        let got = step1(input);
        assert_eq!(got, 2);
    }

    #[test]
    #[should_panic]
    fn test_step2() {
        let input = read_file("inputs/test.txt");
        step2(input);
    }
}
