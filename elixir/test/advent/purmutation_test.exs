defmodule Advent.PurmutationTest do
  use ExUnit.Case, async: true
  alias Advent.Permutation

  test "all/1 creates an array prepresenting all permutations" do
    expected = [
      ~w(london paris nyc sacto),
      ~w(london nyc sacto paris),
      ~w(london sacto paris nyc),
      ~w(paris nyc sacto london),
      ~w(paris sacto london nyc),
      ~w(paris london nyc sacto),
      ~w(nyc sacto london paris),
      ~w(nyc london paris sacto),
      ~w(nyc paris sacto london),
      ~w(sacto london paris nyc),
      ~w(sacto paris nyc london),
      ~w(sacto nyc london paris),
    ]

    assert Permutation.all(~w(london paris nyc sacto)) == expected
  end
end
