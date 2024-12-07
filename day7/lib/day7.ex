defmodule Day7 do
  @moduledoc """
  `Day7`.
  """
  @doc ~S"""
  Solves part 1.
  ```iex

      iex> Day7.part1("190: 10 19")
      190
      iex> Day7.part2("1019: 10 19")
      1019

  ```
  """
  @spec part1(String.t()) :: Integer.t()
  def part1(lines) do
    total(lines, &part1_generator/1)
  end
  @spec part2(String.t()) :: Integer.t()
  def part2(lines) do
    total(lines, &part2_generator/1)
  end

  @spec total(String.t(), (list() -> list())) :: Integer.t()
  def total(lines, generator) do
    lines
    |> String.split("\n")
    # just Enum.map is ok, but this parallelism speeds up the total process up to ~3x
    |> Enum.map(
      &Task.async(fn ->
        line(&1, generator)
      end)
    )
    |> Enum.map(&Task.await/1)
    |> Enum.reduce(&+/2)
  end

  def line(line, generator) do
    case Share.parse_line(line) do
      :empty -> 0
      {expected, nums} ->
        [first | rest] = nums
        result =
          List.duplicate("+", length(rest))
          |> enumerate(generator, fn ops ->
            case Share.calc(first, List.zip([ops, rest])) do
              ^expected -> {:end, :ok}
              _ -> :continue
            end
          end)
        case result do
          :ok -> expected
          :not_found -> 0
        end
    end
  end

  @spec enumerate(list(el), (list(el) -> list(el)), (list(el) -> {:end, t} | :continue)) :: t | :not_found
    when t: var, el: var
  def enumerate(list, next, each) do
    case each.(list) do
      {:end, val} -> val
      :continue -> case next.(list) do
        :end -> :not_found
        other -> enumerate(other, next, each)
      end
    end
  end

  def part1_generator(list) do
    case list do
      [] -> :end
      ["+" | rest] -> ["*" | rest]
      ["*" | rest] -> case part1_generator(rest) do
        :end -> :end
        other -> ["+" | other]
      end
    end
  end

  def part2_generator(list) do
    case list do
      [] -> :end
      ["+" | rest] -> ["*" | rest]
      ["*" | rest] -> ["||" | rest]
      ["||" | rest] -> case part2_generator(rest) do
        :end -> :end
        other -> ["+" | other]
      end
    end
  end
end

defmodule Share do
  @spec parse_line(String.t()) :: {Integer.t(), list()} | :empty
  def parse_line(line) do
    case line |> String.split(":") do
      [""] -> :empty
      [a, b] -> 
        expect = case Integer.parse(a) do
          :error -> IO.puts("Failed to parse " <> a)
          {val, _rest} -> val
        end
        list = b
          |> String.split(" ")
          |> Enum.filter(fn x -> x != "" end)
          |> Enum.map(fn x ->
            case Integer.parse(x) do
              :error -> IO.puts("Failed to parse " <> x)
              {val, _rest} -> val
            end
          end)
        {expect, list}
    end
  end

  @spec calc(Integer.t(), list({String.t(), Integer.t()})) :: Integer.t()
  def calc(init, list) do
    list
    |> Enum.reduce(init, fn x, acc ->
      case x do
        {"+", val} -> acc + val
        {"*", val} -> acc * val
        {"||", val} ->
          case Integer.parse(Integer.to_string(acc) <> Integer.to_string(val)) do
            {res, ""} -> res
          end
      end
    end)
  end
end
