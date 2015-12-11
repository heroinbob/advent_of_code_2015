defmodule Advent.Day8.StringParserTest do
  use ExUnit.Case, async: true
  alias Advent.Day8.StringParser

  test "length_without/2 returns length of the string sans what is specifed" do
    assert "this\nis\nneat\n" |> StringParser.length_without("\n") == 10
  end

  test "print_length/1 returns length of string as it appears on screen" do
    assert "" |> StringParser.print_length == 0
    assert "abc" |> StringParser.print_length == 3
    assert ~s(aaa\\"aaa) |> StringParser.print_length == 7
  end
end
