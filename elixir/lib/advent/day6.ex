defmodule Advent.Day6 do
  alias Advent.Day6.Command
  alias Advent.Day6.Grid

  def instructions do
    File.read!("data/day6.txt")
    |> String.split("\n")
    |> Enum.reject(fn(v) -> v == "" end)
    |> Enum.take(10)
  end

  def light! do
    instructions
    |> Command.parse
    |> do_commands(Grid.new(1_000))
  end

  @doc """
  Returns a grid updated by the actions.
    iex > Advent.Day6.do_commands(
    ...>   [
    ...>    {"on", {1..2, 1..2}},
    ...>    {"off", {3..4, 3..4}},
    ...>    {"toggle", {3..4, 3..4}}
    ...>   ],
    ...>   Grid.new(2)
    ...> )
    []
  """
  def do_commands([command | tail], grid) do
    new_grid = perform(command, grid)
    do_commands(tail, new_grid)
  end

  def do_commands([], grid) do
    grid
  end

  @doc """
  Returns the updated grid with x, y turned on.

    iex> Advent.Day6.perform({"on", {0..1, 0..1}}, Advent.Day6.Grid.new(2))
    [[true, true], [true, true]]
  """
  def perform({"on", {x_range, y_range}}, grid) do
    on(grid, mix(x_range, y_range))
  end

  @doc """
  Returns the updated grid with lights turned off.

    iex> Advent.Day6.perform({"off", {0..1, 0..1}}, Advent.Day6.Grid.new(2, true))
    [[false, false], [false, false]]
  """
  def perform({"off", {x_range, y_range}}, grid) do
    off(grid, mix(x_range, y_range))
  end

  @doc """
  Returns the updated grid with x, y toggled.

    iex> Advent.Day6.perform({"toggle", {0..1, 0..1}}, Advent.Day6.Grid.new(2))
    [[true, false], [true, false]]
  """
  def perform({"toggle", {x_range, y_range}}, grid) do
    toggle(grid, mix(x_range, y_range))
  end

  def on(grid, [coords | tail]) do
    Grid.update(grid, coords, true) |> on(tail)
  end

  def on(grid, []) do
    grid
  end

  def off(grid, [coords | tail]) do
    Grid.update(grid, coords, false) |> off(tail)
  end

  def off(grid, []) do
    grid
  end

  def toggle(grid, [coords | tail]) do
    Grid.toggle(grid, coords) |> toggle(tail)
  end

  def toggle(grid, []) do
    grid
  end

  @doc """
  Returns all possible combinations of the ranges.

    iex> Advent.Day6.mix(1..3, 4..6)
    [{1, 4}, {1, 5}, {1, 6}, {2, 4}, {2, 5}, {2, 6}, {3, 4}, {3, 5}, {3, 6}]
  """
  def mix(range1, range2) do
    Enum.flat_map(range1, fn(r1) ->
      Enum.map(range2, fn(r2) -> {r1, r2} end)
    end)
  end
end
