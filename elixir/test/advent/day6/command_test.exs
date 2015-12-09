defmodule Advent.Day6.CommandTest do
  use ExUnit.Case, async: true

  alias Advent.Day6.Command

  test "ranges/1 returns a tuple of x and y ranges for the command string" do
    assert(Command.ranges("turn on 0,0 through 999,999") == {0..999, 0..999})
  end

  test "new/1 returns a tuple for the command" do
    command = Command.new("turn on 0,0 through 999,999")
    assert(command == {"on", {0..999, 0..999}})

    command = Command.new("toggle 0,0 through 999,0")
    assert(command == {"toggle", {0..999, 0..0}})

    command = Command.new("turn off 499,499 through 500,500")
    assert(command == {"off", {499..500, 499..500}})
  end

  test "parse/2 returns a list of all the commands" do
    commands = Command.parse(
      [
        "turn on 0,0 through 999,999",
        "toggle 0,0 through 999,0",
        "turn off 499,499 through 500,500"
      ]
    )
    expected = [
      {"on", {0..999, 0..999}},
      {"toggle", {0..999, 0..0}},
      {"off", {499..500, 499..500}}
    ]

    assert(commands == expected)
  end
end
