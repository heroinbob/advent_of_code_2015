defmodule Advent.Day8 do
  alias Advent.File
  alias Advent.Day8.StringParser

  def input do
    "day8.txt" |> File.chars
  end

  def test_input do
    "day8_test.txt" |> File.chars
  end

  @doc """
  Returns the count of chars that are decoded, sans whitespace.
    iex> Advent.Day8.decoded_char_count Advent.Day8.test_input
    12

    iex> Advent.Day8.decoded_char_count Advent.Day8.input
    1350
  """
  def decoded_char_count(str) do
    total_length(str) - decoded_length(str)
  end

  @doc """
  Return the count of characters that are added when you encode.
  Whitespace is ignored!
    iex> Advent.Day8.encoded_char_count Advent.Day8.test_input
    19

    iex> Advent.Day8.encoded_char_count Advent.Day8.input
    2085
  """
  def encoded_char_count(str) do
    encoded_length(str) - total_length(str)
  end

  @doc """
  return expanded length
    iex> Advent.Day8.total_length Advent.Day8.test_input
    23

    iex> Advent.Day8.total_length Advent.Day8.input
    6195
  """
  def total_length(str) do
    str |> StringParser.remove("\n") |> String.length
  end

  @doc """
  return expanded length
    iex> Advent.Day8.decoded_length Advent.Day8.test_input
    11

    iex> Advent.Day8.decoded_length Advent.Day8.input
    4845
  """
  def decoded_length(str) do
    str |> StringParser.decode |> StringParser.remove("\n") |> String.length
  end

  @doc """
  return the encoded length, sans whitespace.
    iex> Advent.Day8.encoded_length Advent.Day8.test_input
    42

    iex> Advent.Day8.encoded_length Advent.Day8.input
    8280
  """
  def encoded_length(str) do
    str |> StringParser.encode |> StringParser.remove("\n") |> String.length
  end
end
