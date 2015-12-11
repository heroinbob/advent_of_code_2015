defmodule Advent.Day8.StringParserTest do
  use ExUnit.Case, async: true
  alias Advent.Day8.StringParser
  alias Advent.File

  test "encode/1 escapes double quotes" do
    assert ~s("") |> StringParser.encode == ~s("\\"\\"")
    assert ~s("abc") |> StringParser.encode == ~s("\\"abc\\"")
  end

  test "encode/1 escapes backslashes" do
    assert ~s("aaa\\"aaa") |> StringParser.encode == ~s("\\"aaa\\\\\\"aaa\\"")
    assert ~s("\\x27") |> StringParser.encode == ~s("\\"\\\\x27\\"")
  end

  # Litnus test... use test data and expected count
  test "encode/1 returns the correct encoded characters" do
    chars = "day8_test.txt" |> File.chars
    encoded = chars |> StringParser.encode
    assert  encoded |> StringParser.remove("\n") |> String.length == 42
  end
end
