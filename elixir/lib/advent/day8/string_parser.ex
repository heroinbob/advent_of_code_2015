defmodule Advent.Day8.StringParser do
  def remove(str, value) do
    str |> String.replace(value, "")
  end

  def bookend(str, value) do
    "#{value}#{str}#{value}"
  end

  def decode(str) do
    str
    |> String.replace(~s(\\"), ~s("))
    |> String.replace(~s(\\\\), ~s(\\))
    |> String.replace(~r/\\x[a-f0-9]{2}/, ~s(_))
    |> remove(~r/^"|"\n"|"$/)
  end

  def encode(str) do
    str
    |> String.replace("\\", "\\\\")
    |> String.replace(~s("), ~s(\\"))
    |> String.replace("\n", ~s("\n"))
    |> bookend(~s("))
  end
end
