defmodule Advent.Day9 do
  alias Advent.File

  # Store places and distances
  # pull out unique locations (as starting points)
  # Loop through list... pulling known destinations
  #  - should be all other locations
  #  - track total distance for this path.
  # rinse and repeat til at the final spot.
  # store final value w/ path as key
  # sort by distance
  @doc """
  --- Day 9: All in a Single Night ---

  Every year, Santa manages to deliver all of his presents in a single night.

  This year, however, he has some new locations to visit; his elves have
  provided him the distances between every pair of locations. He can start and
  end at any two (different) locations he wants, but he must visit each
  location exactly once. What is the shortest distance he can travel to
  achieve this?

  For example, given the following distances:

  London to Dublin = 464
  London to Belfast = 518
  Dublin to Belfast = 141
  The possible routes are therefore:

  Dublin -> London -> Belfast = 982
  London -> Dublin -> Belfast = 605
  London -> Belfast -> Dublin = 659
  Dublin -> Belfast -> London = 659
  Belfast -> Dublin -> London = 605
  Belfast -> London -> Dublin = 982
  The shortest of these is London -> Dublin -> Belfast = 605, and so the answer
  is 605 in this example.

  What is the distance of the shortest route?
  """

  def test_input do
    "day9_test.txt" |> File.lines
  end

  def input do
    "day9.txt" |> File.lines
  end

  def known_distances(strings) do
    strings |> Enum.map(fn(str) -> to_known_distance(str) end)
  end

  def to_known_distance(str) do
    pieces = str |> String.split(" ")

    pieces
    |> List.replace_at(length(pieces) - 1, List.last(pieces) |> String.to_integer)
    |> Enum.reject(fn(piece) -> piece == "to" || piece == "=" end) |> List.to_tuple
  end

  def uniq_locations(distances) do
    distances
    |> Enum.flat_map(fn({start, stop, _dist}) -> [start, stop] end)
    |> Enum.uniq
  end

  def go(data) do
    distances = data |> known_distances
    locations = distances |> uniq_locations
    store = HashDict.new

    get_paths(store, distances, locations)
  end

  def get_paths(hash, distances, [current_location | other_locations], path \\ [], total \\ 0) do
    path = path |> List.insert_at(Enum.count(path), current_location)

  end

  def matrixify([place | tail], max, matrix \\ []) do
    matrix = matrix |> List.insert_at(Enum.count(matrix), Enum.concat([place], tail))
    matrix_size = matrix |> Enum.count

    cond do
      matrix_size == max ->
        matrix

      matrix_size < max ->
        matrixify(Enum.concat(tail, [place]), max, matrix)
    end
  end

  def combos_for(current, [next | tail], combos \\ [], count \\ 0) do
    combos = combos |> List.insert_at(count, Enum.concat([current, next], tail))
    count = count + 1

    if count == Enum.count(tail) + 2 do
      combos
    else
      combos_for(current, Enum.concat(tail, [next]), combos, count)
    end
  end
end
