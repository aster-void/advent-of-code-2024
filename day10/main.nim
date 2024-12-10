import sequtils
import strutils
from os import paramStr
from strformat import fmt

func parse(input: string): seq[seq[int]] =
  split(input)
    .mapIt(
      toSeq(it.items)
        .mapIt(fmt"{it}")
        .mapIt(
          try: parseInt(it)
          except: -1)
    )
    .filterIt(it.len > 0)
proc trace(init: seq[seq[int]], field: seq[seq[int]]): seq[seq[int]] =
  let h = field.len
  let w = field[0].len
  var current = init
  for height in 1..9:
    var next = newSeqWith(h, newSeq[int](w))
    for y in 0..<h:
      for x in 0..<w:
        if y > 0 and field[y - 1][x] == height: next[y - 1][x] += current[y][x]
        if x > 0 and field[y][x - 1] == height: next[y][x - 1] += current[y][x]
        if x < w - 1 and field[y][x + 1] == height: next[y][x + 1] += current[y][x]
        if y < h - 1 and field[y + 1][x] == height: next[y + 1][x] += current[y][x]
    current = next
  current

proc part1*(input: string): int =
  let field = parse(input)
  let h = field.len
  let w = field[0].len

  var total = 0
  for y in 0..<h:
    for x in 0..<w:
      if field[y][x] == 0:
        var init = newSeqWith(h, newSeq[int](w))
        init[y][x] = 1
        let final = trace(init, field)
        var sum = 0
        for list in final:
          for item in list:
            if item > 0: sum += 1
        total += sum
  total

proc part2*(input: string): int =
  let field = parse(input)
  let h = field.len
  let w = field[0].len
  var init = newSeqWith(h, newSeq[int](w))
  for y in 0..<h:
    for x in 0..<w:
      if field[y][x] == 0:
        init[y][x] = 1
  trace(init, field).mapIt(it.foldr(a + b)).foldr(a + b)

proc test() =
  assert part1(readFile("test.txt")) == 36
  assert part2(readFile("test.txt")) == 81

when isMainModule:
  case paramStr(1):
  of "test": test()
  of "part1", "1":
    let input = readFile(paramStr(2))
    echo part1(input)
  of "part2", "2":
    let input = readFile(paramStr(2))
    echo part2(input)
  else: echo "Unknown param $paramStr(1). expected: part1, part2, test"
