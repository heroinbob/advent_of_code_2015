defmodule Advent.Day6.Grid do
  def new do
    %{}
  end

  def update(grid, coord, value) do
    Dict.put(grid, key(coord), value)
  end

  def delete(grid, coord) do
    Dict.delete(grid, key(coord))
  end

  def toggle(grid, coord) do
    Dict.get_and_update(grid, key(coord), fn(value) -> {value, !value} end)
    |> Tuple.to_list
    |> List.last
  end

  def key({x, y}) do
    "#{x},#{y}"
  end
end
