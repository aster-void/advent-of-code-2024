defmodule Main do
  case System.argv() do
    [part, file] -> 
      file = File.read!(file)
      cond do
        part in ["1", "part1"] -> Part1.total(file) |> Integer.to_string |> IO.puts
        part in ["2", "part2"] -> Part2.total(file) |> Integer.to_string |> IO.puts
      end
    _ ->
      IO.puts "Please give 2 arguments in the cli arguments, e.g. mix run part1 ./inputs/test.txt"
      exit(1)
  end
end
