use std::collections::HashMap;

use itertools::Itertools;

pub fn step1(input: String) -> usize {
    let mut field = parse_input(input);
    let height = field.len() as isize;
    let width = field.first().unwrap().len() as isize;
    let frequencies = field
        .concat()
        .into_iter()
        .unique()
        .filter(|&ch| ch != '.')
        .filter(|&ch| ch != '#')
        .collect_vec();

    let mut freqs = HashMap::new();
    for freq in frequencies.iter() {
        let mut points = Vec::new();
        for (y, line) in field.iter().enumerate() {
            for (x, char) in line.iter().enumerate() {
                if char == freq {
                    points.push((y as isize, x as isize));
                }
            }
        }
        freqs.insert(*freq, points);
    }

    for freq in frequencies {
        let points = freqs.get(&freq).unwrap();
        for p1 in points.iter() {
            for p2 in points.iter() {
                if p1 == p2 {
                    continue;
                }
                let p1ex = (2 * p1.0 - p2.0, 2 * p1.1 - p2.1);
                let p2ex = (2 * p2.0 - p1.0, 2 * p2.1 - p1.1);
                if 0 <= p1ex.0 && p1ex.0 < height && 0 <= p1ex.1 && p1ex.1 < width {
                    field[p1ex.0 as usize][p1ex.1 as usize] = '#';
                }
                if 0 <= p2ex.0 && p2ex.0 < height && 0 <= p2ex.1 && p2ex.1 < width {
                    field[p2ex.0 as usize][p2ex.1 as usize] = '#';
                }
            }
        }
    }

    let mut ret = 0;
    for line in field.iter() {
        println!("{}", line.iter().join(""));
    }
    for line in field {
        ret += line.into_iter().filter(|ch| *ch == '#').count();
    }
    ret
}
pub fn step2(input: String) -> usize {
    let mut field = parse_input(input);
    let height = field.len() as isize;
    let width = field.first().unwrap().len() as isize;
    let frequencies = field
        .concat()
        .into_iter()
        .unique()
        .filter(|&ch| ch != '.')
        .filter(|&ch| ch != '#')
        .collect_vec();

    let mut freqs = HashMap::new();
    for freq in frequencies.iter() {
        let mut points = Vec::new();
        for (y, line) in field.iter().enumerate() {
            for (x, char) in line.iter().enumerate() {
                if char == freq {
                    points.push((y as isize, x as isize));
                }
            }
        }
        freqs.insert(*freq, points);
    }

    for freq in frequencies {
        let points = freqs.get(&freq).unwrap();
        for p1 in points.iter() {
            for p2 in points.iter() {
                if p1 == p2 {
                    continue;
                }
                let mut p1ex = p1.to_owned();
                let mut p2ex = p2.to_owned();
                p1ex.0 += p2.0 - p1.0;
                p1ex.1 += p2.1 - p1.1;
                while 0 <= p1ex.0 && p1ex.0 < height && 0 <= p1ex.1 && p1ex.1 < width {
                    field[p1ex.0 as usize][p1ex.1 as usize] = '#';
                    p1ex.0 += p2.0 - p1.0;
                    p1ex.1 += p2.1 - p1.1;
                }
                p2ex.0 += p1.0 - p2.0;
                p2ex.1 += p1.1 - p2.1;
                while 0 <= p2ex.0 && p2ex.0 < height && 0 <= p2ex.1 && p2ex.1 < width {
                    field[p2ex.0 as usize][p2ex.1 as usize] = '#';
                    p2ex.0 += p1.0 - p2.0;
                    p2ex.1 += p1.1 - p2.1;
                }
            }
        }
    }

    let mut ret = 0;
    for line in field.iter() {
        println!("{}", line.iter().join(""));
    }
    for line in field {
        ret += line.into_iter().filter(|ch| *ch == '#').count();
    }
    ret
}

fn parse_input(input: String) -> Vec<Vec<char>> {
    input
        .split("\n")
        .map(|line| line.chars().collect())
        .filter(|line: &Vec<char>| !line.is_empty())
        .collect()
}
// -- utils & tests
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
        assert_eq!(got, 14);
    }

    #[test]
    fn test_step2() {
        let input = read_file("inputs/test.txt");
        let got = step2(input);
        assert_eq!(got, 34);
    }
}
