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
    total(lines, ["+", "*"])
  end
  @spec part2(String.t()) :: Integer.t()
  def part2(lines) do
    total(lines, ["+", "*", "||"])
  end

  @spec total(String.t(), list(String.t())) :: Integer.t()
  def total(lines, operators) do
    lines
    |> String.split("\n")
    # just Enum.map is ok, but this parallelism speeds up the total process up to ~3x
    |> Enum.map(
      &Task.async(fn ->
        line(&1, operators)
      end)
    )
    |> Enum.map(&Task.await/1)
    |> Enum.reduce(&+/2)
  end

  def line(line, operators) do
    case Share.parse_line(line) do
      :empty -> 0
      {expected, nums} ->
        result =
          enumerate(length(nums) - 1, operators, fn ops ->
            case Share.calc(nums, ops) do
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

  @spec enumerate(Integer.t(), list(String.t()), (list(String.t()) -> {:end, t} | :continue)) :: t | :not_found
    when t: var
  def enumerate(for, operators, each) when is_integer(for) do
    init = List.duplicate(List.first(operators), for)
    enumerate(init, operators, each)
  end

  @spec enumerate(list(String.t()), list(String.t()), (list(String.t()) -> {:end, t} | :continue)) :: t | :not_found
    when t: var
  def enumerate(list, operators, each)
    when is_list(list)
  do
    case each.(list) do
      {:end, val} -> val
      :continue -> case next(list, operators) do
        :end -> :not_found
        other -> enumerate(other, operators, each)
      end
    end
  end

  def next(list, operators) do
    case list do
      [] -> :end
      [op | rest] ->
        if op == List.last(operators) do
          case next(rest, operators) do
            :end -> :end
            other -> [List.first(operators) | other]
          end
        else
          index = Share.find_index(operators, op)
          new = operators |> Enum.at(index + 1)
          [new | rest]
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

  @spec calc(list(Integer.t()), list(String.t())) :: Integer.t()
  def calc(list, operations) do
    [init | rem] = list
    Enum.reduce(List.zip([operations, rem]), init, fn op, acc ->
      case op do
        {"+", val} -> acc + val
        {"*", val} -> acc * val
        {"||", val} ->
          case Integer.parse(Integer.to_string(acc) <> Integer.to_string(val)) do
            {res, ""} -> res
          end
      end
    end)
  end

  @spec find_index(list(t), t) :: non_neg_integer() | nil
    when t: any
  def find_index(list, el) do
    Enum.find_index(list, fn x -> el == x end)
  end
end
