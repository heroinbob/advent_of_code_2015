defmodule Advent.Day6.GridTest do
  use ExUnit.Case, async: true

  alias Advent.Day6.Grid

  test "new/0 returns a new dict" do
    assert Grid.new == %{}
  end

  test "value/2 returns the value at coords, or 0 if not set" do
    assert Grid.value(%{}, {1, 1}) == 0
    assert Grid.value(%{"1,1" => 5}, {1, 1}) == 5
  end

  test "increase/2 increases value at coords by 1" do
    assert Grid.increase(%{"7,7" => 1}, {7, 7}) == %{"7,7" => 2}
    assert Grid.increase(%{}, {7, 7}) == %{"7,7" => 1}
  end

  test "decrease/2 decreases coord by 1, min 0" do
    assert Grid.decrease(%{"1,1" => 2}, {1, 1}) == %{"1,1" => 1}
    assert Grid.decrease(%{}, {1, 1}) == %{"1,1" => 0}
    assert Grid.decrease(%{"1,1" => 0}, {1, 1}) == %{"1,1" => 0}
  end

  test "toggle/2 turns on the light when off" do
    assert Grid.toggle(%{}, {1, 1}) == %{"1,1" => 2}
  end

  test "toggle/2 turns off the light when on" do
    assert Grid.toggle(%{}, {1, 1}) == %{"1,1" => 2}
  end

  test "increment/2 increments the value by amount, accounting for nil" do
    assert Grid.increment(1, 10) == 11
    assert Grid.increment(nil, 5) == 5
  end
end
