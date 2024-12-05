import argv
import gleam/bool
import gleam/int
import gleam/io
import gleam/list
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
    "1" -> part1(file)
    "2" -> part2(file)
    _ -> {
      let text = "unknown part: expected 1 or 2, got " <> part
      panic as text
    }
  }
  |> int.to_string
  |> io.println
}

pub fn part1(input: String) {
  let assert Ok(#(first, second)) =
    input
    |> string.split_once(on: "\n\n")

  let req = parse_first_part(first)
  let lines = parse_second_part(second)
  lines
  |> list.filter(keeping: fn(line) { line_ok(line, req) })
  |> list.map(io.debug)
  |> list.map(take_middle_and_parse)
  |> int.sum
}

pub fn part2(input: String) {
  let assert Ok(#(first, second)) =
    input
    |> string.split_once(on: "\n\n")

  let req = parse_first_part(first)
  let lines = parse_second_part(second)
  lines
  |> list.filter(keeping: fn(line) { !line_ok(line, req) })
  |> list.map(fn(line) { fix_issue(line, req) })
  |> list.map(io.debug)
  |> list.map(take_middle_and_parse)
  |> int.sum
}

fn take_middle_and_parse(l: List(String)) {
  let assert Ok(val) =
    l
    |> list.drop({ list.length(l) - 1 } / 2)
    |> list.first
  let assert Ok(val) = int.parse(val)
  val
}

fn parse_first_part(first) {
  first
  |> string.split("\n")
  |> list.filter(fn(line) { line != "" })
  |> list.map(fn(line) {
    let assert Ok(entry) = string.split_once(line, on: "|")
    entry
  })
}

fn parse_second_part(second) {
  second
  |> string.split("\n")
  |> list.filter(fn(line) { line != "" })
  |> list.map(fn(line) { string.split(line, on: ",") })
}

fn fix_issue(line, reqs) {
  let reqs =
    list.filter(reqs, fn(a) {
      let #(k, v) = a
      list.contains(line, k) && list.contains(line, v)
    })
  io.debug(reqs)
  fix_issue_rec(line, reqs)
}

fn fix_issue_rec(line: List(String), reqs: List(#(String, String))) {
  case line {
    [] -> []
    [head, ..rest] -> {
      reqs
      |> list.fold(from: #(False, head, rest), with: fn(state, must) {
        let #(prev, head, rest) = state
        use <- bool.guard(when: head != must.1, return: #(prev, head, rest))
        case rest |> list.contains(must.0) {
          False -> #(prev, head, rest)
          True -> {
            let next = #(
              True,
              must.0,
              replace_first(rest, replace: must.0, with: must.1),
            )
            io.debug(must.0 <> "<>" <> must.1)
            io.debug(
              "Reordered from "
              <> string.join([head, ..rest], ",")
              <> " to "
              <> string.join([next.1, ..next.2], ","),
            )
            next
          }
        }
      })
      |> fn(state) {
        let #(did_swap, head, rest) = state
        case did_swap {
          True -> fix_issue_rec([head, ..rest], reqs)
          False -> [head, ..fix_issue_rec(rest, reqs)]
        }
      }
    }
  }
}

fn line_ok(line, reqs) {
  let reqs =
    reqs
    |> list.filter(fn(a) {
      let #(k, v) = a
      list.contains(line, k) && list.contains(line, v)
    })
  line_ok_rec(list.reverse(line), reqs)
}

fn line_ok_rec(line, reqs: List(#(a, a))) {
  case line {
    [] -> True
    [top, ..rest] -> {
      let top_ok =
        reqs
        |> list.filter(fn(req) { req.1 == top })
        |> list.all(fn(a) { rest |> list.contains(a.0) })
      top_ok && line_ok_rec(rest, reqs)
    }
  }
}

pub fn replace_first(in ls: List(a), replace source: a, with target: a) {
  case ls {
    [] -> []
    [head, ..rest] -> {
      case head == source {
        False -> [head, ..replace_first(rest, source, target)]
        True -> [target, ..rest]
      }
    }
  }
}
