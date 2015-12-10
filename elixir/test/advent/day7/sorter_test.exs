defmodule Advent.Day7.SorterTest do
  use ExUnit.Case, async: true
  alias Advent.Day7.Sorter

  test "sort/1 sorts the commands DESC, via destination" do
    commands = [
      {:NOT, {:x}, :b},
      {:RSHIFT, {:x, :y}, :ag},
      {:OR, {:x, :y}, :a},
      {:LSHIFT, {:x, :y}, :bs},
      {:ASSIGN, {:x}, :cz},
      {:AND, {:x, :y}, :c}
    ]
    expected = [
      {:OR, {:x, :y}, :a},
      {:NOT, {:x}, :b},
      {:AND, {:x, :y}, :c},
      {:RSHIFT, {:x, :y}, :ag},
      {:LSHIFT, {:x, :y}, :bs},
      {:ASSIGN, {:x}, :cz}
    ]

    assert Sorter.sort(commands) == expected
  end
end
