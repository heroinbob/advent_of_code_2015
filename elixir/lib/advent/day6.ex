defmodule Advent.Day6 do
  alias Advent.Day6.Command
  alias Advent.Day6.Grid
  alias Advent.File

  def instructions do
    "day6.txt" |> File.split |> Command.parse
  end

  def light! do
    performer = fn(instruction, lights) -> perform(instruction, lights) end
    Enum.reduce(instructions, Grid.new, performer)
  end

  # Answer is 377891!
  def lit_count do
    light! |> Enum.count(fn{_, state} -> state > 0 end)
  end

  # Answer is 14110788!
  def lumens do
    light!
    |> Dict.values
    |> Enum.reduce(0, fn(value, acc) -> value + acc end)
  end

  def perform({"on", ranges}, grid) do
    on(grid, mix(ranges))
  end

  def perform({"off", ranges}, grid) do
    off(grid, mix(ranges))
  end

  def perform({"toggle", ranges}, grid) do
    toggle(grid, mix(ranges))
  end

  def on(grid, [coord | tail]) do
    Grid.increase(grid, coord) |> on(tail)
  end

  def on(grid, []) do
    grid
  end

  def off(grid, [coord | tail]) do
    Grid.decrease(grid, coord) |> off(tail)
  end

  def off(grid, []) do
    grid
  end

  def toggle(grid, [coord | tail]) do
    Grid.toggle(grid, coord) |> toggle(tail)
  end

  def toggle(grid, []) do
    grid
  end

  @doc """
  Returns all possible combinations of the ranges.

    iex> Advent.Day6.mix({1..3, 4..6})
    [{1, 4}, {1, 5}, {1, 6}, {2, 4}, {2, 5}, {2, 6}, {3, 4}, {3, 5}, {3, 6}]
  """
  def mix({range1, range2}) do
    Enum.flat_map(range1, fn(r1) ->
      Enum.map(range2, fn(r2) -> {r1, r2} end)
    end)
  end
end
