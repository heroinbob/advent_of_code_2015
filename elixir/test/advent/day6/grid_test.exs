defmodule Advent.Day6.GridTest do
  use ExUnit.Case, async: true

  alias Advent.Day6.Grid

  test "new/2 when size is 3 creates a 2x2 grid with 3 rows and columns" do
    expected = [[0,0,0],[0,0,0],[0,0,0]]
    assert(Grid.new(3, 0) == expected)
  end

  test "value/2 returns the correct value for the grid and coords" do
    grid = [[0,0,0],[0,0,1],[0,0,0]]
    assert(Grid.value(grid, {2, 1}) == 1)
    assert(Grid.value(grid, {0, 0}) == 0)
    assert(Grid.value(grid, {2, 2}) == 0)
  end

  test "update/3 sets the value at the specified coords" do
    grid = [[0,0,0],[0,0,0],[0,0,0]]

    assert(Grid.update(grid, {0, 0}, 1) == [[1,0,0],[0,0,0],[0,0,0]])
    assert(Grid.update(grid, {1, 1}, 1) == [[0,0,0],[0,1,0],[0,0,0]])
    assert(Grid.update(grid, {2, 2}, 1) == [[0,0,0],[0,0,0],[0,0,1]])
  end

  test "toggle/2 turns on the light when off" do
    grid = [[false, false], [true, true]]

    assert(Grid.toggle(grid, {0, 0}) == [[true, false], [true, true]])
    assert(Grid.toggle(grid, {1, 1}) == [[false, false], [true, false]])
  end
end
