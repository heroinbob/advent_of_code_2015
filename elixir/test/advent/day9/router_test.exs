defmodule Advent.Day9.RouterTest do
  use ExUnit.Case, async: true
  alias Advent.Day9.Router
  alias Advent.File

  test "parse_map/1 parses data for the distances" do
    data = "day9_test.txt" |> File.lines
    expected_distances = [
      {"London", "Dublin", 464},
      {"London", "Belfast", 518},
      {"Dublin", "Belfast", 141}
    ]

    assert Router.parse_map(data) == expected_distances
  end

  test "calculate_route_distance/1 calculates the route paths and distances" do
    map = [
      {"London", "Dublin", 464},
      {"London", "Belfast", 518},
      {"Dublin", "Belfast", 141}
    ]

    assert ~w(Belfast London Dublin) |> Router.calculate_route_distance(map) == 982
    assert ~w(London Belfast Dublin) |> Router.calculate_route_distance(map) == 659
  end

  test "all_routes/1 returns a list of routes (ordered stops)" do
    map = [
      {"London", "Dublin", 464},
      {"London", "Belfast", 518},
      {"Dublin", "Belfast", 141}
    ]
    expected =[
      ~w(London Dublin Belfast),
      ~w(London Belfast Dublin),
      ~w(Dublin Belfast London),
      ~w(Dublin London Belfast),
      ~w(Belfast London Dublin),
      ~w(Belfast Dublin London)
    ]
    assert map |> Router.routes == expected
  end
end
