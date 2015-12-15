defmodule Advent.CombinationTest do
  use ExUnit.Case, async: true
  alias Advent.Combination

  test "all/1 creates an array prepresenting all possible combinations" do
    expected = [
      ~w(a b c),
      ~w(a c b),
      ~w(b c a),
      ~w(b a c),
      ~w(c a b),
      ~w(c b a)
    ]

    assert Combination.all(~w(a b c)) == expected
  end
end
