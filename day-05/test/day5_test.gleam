import day5
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn part1_test() {
  let input = day5.read_file("inputs/test.txt")
  input
  |> day5.part1
  |> should.equal(143)
}

pub fn part2_test() {
  let input = day5.read_file("inputs/test.txt")
  input
  |> day5.part2
  |> should.equal(123)
}
