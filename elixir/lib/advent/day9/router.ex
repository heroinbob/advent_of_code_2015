defmodule Advent.Day9.Router do
  alias Advent.Combination

  def parse_map(data) do
    data |> Enum.map(fn(str) -> to_distance(str) end)
  end

  @doc """
  Calculate the distance for the route given the distances.

  For example:
    route = ~w(b c a)
    distances = [{"a", "b", 10}, {"b", "c", 20}, {"c", "a", 30}]
    distance = route |> calculate_with(distances)
    50

  This would return the total distance for the route, using distances
  as a list of Tuples providing the known distances.
  """
  def calculate_route_distance([current_stop | others], map, total \\ 0) do
    dist =
      current_stop
      |> distance_from(others, map)
      |> Tuple.to_list
      |> List.last

    calculate_route_distance(others, map, total + dist)
  end

  def calculate_route_distance([], _map, total) do
    total # All done, return the total.
  end

  def routes(map) do
    map |> uniq_locations |> Combination.all
  end

  def shortest_path(input) do
    path_length(input, asc_sorter)
  end

  def longest_path(input) do
    path_length(input, desc_sorter)
  end

  defp path_length(str, sorter_fn) do
    map = str |> parse_map
    routes = map |> routes

    Enum.reduce(
      routes,
      HashDict.new,
      fn(stops, hash) ->
        distance = stops |> calculate_route_distance(map)
        HashDict.put(hash, Enum.join(stops, "->"), distance)
      end
    )
    |> Enum.sort(sorter_fn)
    |> List.first
  end

  defp desc_sorter do
    fn({_a_key, a_dist}, {_b_key, b_dist}) -> a_dist > b_dist end
  end

  defp asc_sorter do
    fn({_a_key, a_dist}, {_b_key, b_dist}) -> a_dist < b_dist end
  end

  defp to_distance(str) do
    pieces = str |> String.split(" ")
    index = (pieces |> length) - 1
    int_dist = pieces |> List.last |> String.to_integer

    pieces
    |> List.replace_at(index, int_dist)
    |> Enum.reject(fn(piece) -> piece == "to" || piece == "=" end) |> List.to_tuple
  end

  defp match?(values, current, [next | _rest]) do
    values |> Enum.any?(fn(v) -> v == current end) &&
      values |> Enum.any?(fn(v) -> v == next end)
  end

  defp match?(_values, _current, []) do
    false # All done, return false and move on.
  end

  defp distance_from(place1, other_places, map) do
    map
    |> Enum.find(
      {"", "", 0}, # default if not found.
      fn(distance) ->
        distance
        |> Tuple.to_list
        |> Enum.take(2) # dist is last, not needed.
        |> match?(place1, other_places)
      end
    )
  end

  defp uniq_locations(map) do
    map
    |> Enum.flat_map(fn({start, stop, _dist}) -> [start, stop] end)
    |> Enum.uniq
  end
end
