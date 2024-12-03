import day1
import gleeunit
import gleeunit/should
import simplifile

pub fn main() {
  gleeunit.main()
}

pub fn step1_test() {
  simplifile.read("./inputs/test.txt")
  |> should.be_ok
  |> day1.solve_part1
  |> should.equal(11)
}

pub fn step2_test() {
  simplifile.read("./inputs/test.txt")
  |> should.be_ok
  |> day1.solve_part2
  |> should.equal(31)
}
