defmodule Part1 do
  @moduledoc """
  Documentation for `Day7 - Part1`.
  """

  @doc """
  Solves part 1.

  ## Examples

      iex> Part1.total("190: 10 19")
      190

      iex> Part1.total("191: 10 19")
      0

  """
  @spec total(String.t()) :: Integer.t()
  def total(lines) do
    lines
    |> String.split("\n")
    |> Enum.map(&(line &1))
    |> Enum.reduce(&+/2)
  end

  def line(line) do
    case Share.parse_line(line) do
      :empty -> 0
      {expected, nums} -> 
        [first | rest] = nums
        result = List.duplicate("+", length(nums) - 1)
        |> enumerate(fn x ->
          case Share.calc(first, List.zip([x, rest])) do
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

  def enumerate(list, func) do
    case func.(list) do
      {:end, val} -> val
      :continue -> case next_of(list) do
        :end -> :not_found
        other -> enumerate(other, func)
      end
    end
  end
  def next_of(list) do
    case list do
      [] -> :end
      ["+" | rest] -> ["*" | rest]
      ["*" | rest] -> 
        case next_of(rest) do
          :end -> :end
          other -> ["+" | other]
        end
    end
  end
end

defmodule Part2 do
  @spec total(String.t()) :: Integer.t()
  def total(lines) do
    lines
    |> String.split("\n")
    |> Enum.map(&(line&1))
    |> Enum.reduce(&+/2)
  end
  def line(line) do
    case Share.parse_line(line) do
      :empty -> 0
      {expected, nums} -> 
        [first | rest] = nums
        result = List.duplicate("+", length(nums) - 1)
        |> enumerate(fn x ->
          case Share.calc(first, List.zip([x, rest])) do
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
  def enumerate(list, func) do
    case func.(list) do
      {:end, val} -> 
        val
      :continue -> case next_of(list) do
        :end -> 
          :not_found
        other -> enumerate(other, func)
      end
    end
  end
  def next_of(list) do
    case list do
      [] -> :end
      ["+" | rest] -> ["*" | rest]
      ["*" | rest] -> ["||" | rest]
      ["||" | rest] ->
        case next_of(rest) do
          :end -> :end
          other -> ["+" | other]
        end
    end
  end
end

defmodule Share do
  @spec parse_line(String.t()) :: {Integer.t(), list()}
  def parse_line(line) do
    case line |> String.split(":") do
      [""] -> :empty
      [a, b] -> {
        case Integer.parse(a) do
          :error -> IO.puts "Failed to parse " <> a
          {val, _rest} -> val
        end,
        b
        |> String.split(" ")
        |> Enum.filter(fn x -> x != "" end)
        |> Enum.map(fn x ->
          case Integer.parse x do 
            :error -> IO.puts "Failed to parse " <> x
            {val, _rest} -> val
          end
        end)
      }
    end
  end
  @spec calc(Integer.t(), list({String.t(), Integer.t()})) :: Integer.t()
  def calc(init, list) do
    list
    |> Enum.reduce(init, fn x, acc ->
      case x do
        {"+", val} -> acc + val
        {"*", val} -> acc * val
        {"||", val} -> case Integer.parse(Integer.to_string(acc) <> Integer.to_string(val)) do
            {res, ""} -> res
          end
      end
    end)
  end
end
