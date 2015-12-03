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
    commands
    |> visits
    |> length
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
    Dict.keys(map)
  end

  def mark_spot(map, x, y) do
    key = "#{x},#{y}"
    Dict.put(map, key, 1)
  end

  def visits(commands) do
    map = mark_spot(HashDict.new, 0, 0)
    move(commands, 0, 0, map)
  end

  @doc """
  --- Part Two ---

  The next year, to speed up the process, Santa creates a robot version of
  himself, Robo-Santa, to deliver presents with him.

  Santa and Robo-Santa start at the same location (delivering two presents to
  the same starting house), then take turns moving based on instructions from
  the elf, who is eggnoggedly reading from the same script as the previous year.

  This year, how many houses receive at least one present?

  For example:

  ^v delivers presents to 3 houses, because Santa goes north, and then
  Robo-Santa goes south.

  ^>v< now delivers presents to 3 houses, and Santa and Robo-Santa end up back
  where they started.

  ^v^v^v^v^v now delivers presents to 11 houses, with Santa going one direction
  and Robo-Santa going the other.

  Correct answer is 2361 for my data set.
  """
  def take_turns(commands) do
    santa_visits(commands)
    |> Enum.concat(robot_visits(commands))
    |> Enum.uniq
    |> length
  end

  def santa_visits(commands) do
    isolate(commands, 0) |> visits
  end

  def robot_visits(commands) do
    isolate(commands, 1) |> visits
  end

  def isolate(commands, start_index) do
    size = String.length(commands)

    String.slice(commands, start_index..size)
    |> String.split("")
    |> Enum.take_every(2)
    |> Enum.join("")
  end
end
