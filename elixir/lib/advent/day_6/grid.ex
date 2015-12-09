defmodule Advent.Day6.Grid do
  def new(size, value \\ false) do
    Enum.to_list(1..size) |> Enum.map(fn(_) -> new_row(size, value) end)
  end

  def new_row(size, value) do
    Enum.to_list(1..size) |> Enum.map(fn(_) -> value end)
  end

  def value(grid, {x, y}) do
    Enum.at(grid, y) |> Enum.at(x)
  end

  def update(grid, {x, y}, value) do
    row = Enum.at(grid, y)
    updated_row = List.replace_at(row, x, value)
    List.replace_at(grid, y, updated_row)
  end

  def toggle(grid, coord) do
    update(grid, coord, !value(grid, coord))
  end
end
