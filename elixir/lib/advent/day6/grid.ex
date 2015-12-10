defmodule Advent.Day6.Grid do
  def new do
    %{}
  end

  def value(grid, coord) do
    Dict.get(grid, key(coord), 0)
  end

  def increase(grid, coord) do
    n = value(grid, coord)
    Dict.put(grid, key(coord), n + 1)
  end

  def decrease(grid, coord) do
    n = value(grid, coord)
    Dict.put(grid, key(coord), max(n - 1, 0))
  end

  def toggle(grid, coord) do
    toggler = fn(value) -> {value, increment(value, 2)} end

    Dict.get_and_update(grid, key(coord), toggler)
    |> Tuple.to_list
    |> List.last
  end

  def key({x, y}) do
    "#{x},#{y}"
  end

  def increment(value, amount) do
    if value == nil do
      amount
    else
      value + amount
    end
  end
end
