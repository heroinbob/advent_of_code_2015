defmodule Advent.Day7.Computer do
  use Bitwise

  def compute({:ASSIGN, value, _dest}, hash) do
    value_of(value, hash)
  end

  def compute({:NOT, value, _dest}, hash) do
    value_of(value, hash) |> bnot
  end

  def compute({:AND, {a, b}, _dest}, hash) do
    band(value_of(a, hash), value_of(b, hash))
  end

  def compute({:OR, {a, b}, _dest}, hash) do
    bor(value_of(a, hash), value_of(b, hash))
  end

  def compute({:RSHIFT, {a, b}, _dest}, hash) do
    bsr(value_of(a, hash), value_of(b, hash))
  end

  def compute({:LSHIFT, {a, b}, _dest}, hash) do
    bsl(value_of(a, hash), value_of(b, hash))
  end

  defp value_of(input, hash) do
    if is_integer(input) do
      input
    else
      hash |> HashDict.get(input)
    end
  end
end
