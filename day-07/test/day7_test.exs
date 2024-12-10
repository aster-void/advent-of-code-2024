defmodule Day7Test do
  use ExUnit.Case

  test "part1" do
    file = File.read!("inputs/test.txt")
    assert Day7.part1(file) == 3749
  end

  test "part2" do
    file = File.read!("inputs/test.txt")
    assert Day7.part2(file) == 11387
  end

  test "per line part1" do
    assert Day7.part1("190: 10 19") == 190
  end

  test "per line part2" do
    assert Day7.part2("192: 17 8 14") == 192
  end
end
