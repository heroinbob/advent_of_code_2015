defmodule Advent.Day8.StringParser do
  def remove(str, value) do
    str |> String.replace(value, "")
  end

  def length_without(str, value) do
    str |> remove(value) |> String.length
  end

  def print_length(str) do
    str
    |> String.replace(~s(\\"), ~s("))
    |> String.replace(~s(\\\\), ~s(\\))
    |> String.replace(~r/\\x[a-f0-9]{2}/, ~s(_))
    |> remove(~r/^"|"\n"|"$/)
    |> remove("\n")
    |> String.length
  end
end
