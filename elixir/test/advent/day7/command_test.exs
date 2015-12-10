defmodule Advent.Day7.CommandTest do
  use ExUnit.Case, async: true

  alias Advent.Day7.Command

  test "parse/1 converts string commands to tuples" do
    commands = [
      "NOT y -> z",
      "a OR 1 -> c",
      "1 AND e -> f",
      "g RSHIFT h -> i",
      "1 LSHIFT k -> l"
    ]
    expected = [
      {:NOT, :y, :z},
      {:OR, {:a, 1}, :c},
      {:AND, {1, :e}, :f},
      {:RSHIFT, {:g, :h}, :i},
      {:LSHIFT, {1, :k}, :l},
    ]
    assert Command.parse(commands) == expected
  end

  test "parse/1 converts string assignments to tuples" do
    commands = ["1 -> x", "x -> y"]
    expected = [{:ASSIGN, 1, :x}, {:ASSIGN, :x, :y}]

    assert Command.parse(commands) == expected
  end
end
