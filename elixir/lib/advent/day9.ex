defmodule Advent.Day9 do
  alias Advent.File
  alias Advent.Day9.Router

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

  @doc """
  Returns the shortest path!
    iex> Advent.Day9.test_input |> Advent.Day9.shortest_path
    {"London->Dublin->Belfast", 605}

    iex > Advent.Day9.input |> Advent.Day9.shortest_path
    {"Arbre->Tambi->Snowdin->Faerun->Straylight->Norrath->AlphaCentauri->Tristram", 141}
  """
  def shortest_path(str) do
    map = str |> Router.parse_map
    routes = map |> Router.routes

    Enum.reduce(
      routes,
      HashDict.new,
      fn(stops, hash) ->
        distance = stops |> Router.calculate_route_distance(map)
        HashDict.put(hash, Enum.join(stops, "->"), distance)
      end
    )
    |> Enum.sort(fn({_a_key, a_dist}, {_b_key, b_dist}) -> a_dist < b_dist end)
    |> List.first
  end
end
