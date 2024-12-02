import argv
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  let args = argv.load().arguments
  let #(part, file) = case args {
    [part, file] -> #(part, file)
    _ ->
      panic as "you must provide part and file path in argument e.g. `gleam run 1 ./inputs/test.txt`"
  }
  let file = simplifile.read(from: file)
  let file = case file {
    Ok(f) -> f
    Error(err) -> {
      io.debug(err)
      panic
    }
  }

  case part {
    "1" -> solve_part1(file)
    "2" -> solve_part2(file)
    _ -> panic as "unknown part: expected 1 or 2"
  }
  |> int.to_string
  |> io.println
}

pub fn solve_part1(input: String) -> Int {
  let #(left, right) = parse_into_lists(input)
  let left = left |> list.sort(by: int.compare)
  let right = right |> list.sort(by: int.compare)

  list.map2(left, right, int.subtract)
  |> list.map(int.absolute_value)
  |> int.sum
}

pub fn solve_part2(input: String) -> Int {
  let #(left, right) = parse_into_lists(input)
  left
  |> list.map(fn(val) { val * list.count(right, fn(a) { a == val }) })
  |> int.sum
}

fn parse_into_lists(input: String) -> #(List(Int), List(Int)) {
  input
  |> string.split(on: "\n")
  |> list.filter_map(fn(line) {
    case string.split(line, on: " ") {
      [first, second, ..rem] -> {
        let assert Ok(first) = int.parse(first)
        let assert Ok(last) =
          list.last(rem)
          |> result.unwrap(second)
          |> int.parse
        Ok(#(first, last))
      }
      _ -> Error(Nil)
    }
  })
  |> list.unzip
}
