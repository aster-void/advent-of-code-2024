defmodule Day7Test do
  use ExUnit.Case

  test "part1" do
    file = File.read!("inputs/test.txt")
    assert Part1.total(file) == 3749
  end
  test "part2" do
    file = File.read!("inputs/test.txt")
    assert Part2.total(file) == 11387
  end
  test "per line -- part1" do
    assert Part1.line("190: 10 19") == 190
  end
  test "per line -- part2" do
    assert Part2.line("192: 17 8 14") == 192
  end
  test "per line part2" do
    assert Part2.line("10: 1 0") == 10
  end
end
