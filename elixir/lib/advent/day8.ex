defmodule Advent.Day8 do
  alias Advent.File
  alias Advent.Day8.StringParser

  def input do
    "day8.txt" |> File.chars
  end

  @doc """
  Returns the count of chars that do not print (not including whitespace)
    iex> Advent.Day8.non_printing_length
    1350
  """
  def non_printing_length do
    str = input
    total_length(input) - in_mem_length(input)
  end

  @doc """
  return expanded length
    iex> Advent.Day8.total_length Advent.Day8.input
    6195
  """
  def total_length(str) do
    str |> StringParser.length_without("\n")
  end

  @doc """
  return expanded length
    iex> Advent.Day8.in_mem_length Advent.Day8.input
    4845
  """
  def in_mem_length(str) do
    str |> StringParser.print_length
  end
end
