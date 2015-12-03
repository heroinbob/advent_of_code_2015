defmodule Advent.Day3 do
  @doc """
  --- Day 3: Perfectly Spherical Houses in a Vacuum ---

  Santa is delivering presents to an infinite two-dimensional grid of houses.

  He begins by delivering a present to the house at his starting location, and
  then an elf at the North Pole calls him via radio and tells him where to move
  next. Moves are always exactly one house to the north (^), south (v),
  east (>), or west (<). After each move, he delivers another present to the
  house at his new location.

  However, the elf back at the north pole has had a little too much eggnog, and
  so his directions are a little off, and Santa ends up visiting some houses
  more than once. How many houses receive at least one present?

  For example:

  > delivers presents to 2 houses: one at the starting location, and one to the east.
  ^>v< delivers presents to 4 houses in a square, including twice to the house
  at his starting/ending location.
  ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.

  Approach:
  Track visited coordinates!
  Start with [{0,0}], x=0, y=0

  Move up "^" -[{0,0},{0,1}] x=0, y=1 ... and so on.
  - Add tuple if not found

  FYI - I should get 2572 from my input!
  """

  def unique_houses(commands) do
    map = mark_spot(HashDict.new, 0, 0)
    move(commands, 0, 0, map)
  end

  def move(">" <> rest, x, y, map) do
    new_x = x + 1
    new_map = mark_spot(map, new_x, y)
    move(rest, new_x, y, new_map)
  end

  def move("<" <> rest, x, y, map) do
    new_x = x - 1
    new_map = mark_spot(map, new_x, y)
    move(rest, new_x, y, new_map)
  end

  def move("^" <> rest, x, y, map) do
    new_y = y + 1
    new_map = mark_spot(map, x, new_y)
    move(rest, x, new_y, new_map)
  end

  def move("v" <> rest, x, y, map) do
    new_y = y - 1
    new_map = mark_spot(map, x, new_y)
    move(rest, x, new_y, new_map)
  end

  def move("", _x, _y, map) do
    Enum.count(Dict.keys(map))
  end

  def mark_spot(map, x, y) do
    key = "#{x},#{y}"
    Dict.put(map, key, 1)
  end
end
