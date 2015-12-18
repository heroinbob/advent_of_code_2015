defmodule Advent.Day10Test do
  use ExUnit.Case, async: true
  alias Advent.Day10

  test "look_and_say/1 returns the outcome of x" do
    assert Day10.look_and_say("1") == "11"
    assert Day10.look_and_say("11") == "21"
    assert Day10.look_and_say("21") == "1211"
    assert Day10.look_and_say("1211") == "111221"
    assert Day10.look_and_say("111221") == "312211"
  end

  test "look_and_say/2 returns the outcome for value after n iterations" do
    assert Day10.look_and_say("1", 5) == "312211"
  end
end
