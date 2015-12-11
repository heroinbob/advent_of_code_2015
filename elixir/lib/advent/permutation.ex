defmodule Advent.Permutation do
  import Advent.List

  def all([current | others], matrix \\ [], processed \\ []) do
    permutations = permutations_of(current, Enum.concat(others, processed))
    matrix = matrix |> Enum.concat(permutations)
    processed = processed |> add_value_to_list(current)

    all(others, matrix, processed)
  end

  def all([], matrix, _processed) do
    matrix
  end

  defp permutations_of(current, [next | tail], permutations \\ []) do
    permutation = Enum.concat([current, next], tail)
    permutations = permutations |> add_value_to_list(permutation)

    cond do
      Enum.count(tail) + 1 == Enum.count(permutations) ->
        permutations

      true ->
        permutations_of(current, add_value_to_list(tail, next), permutations)
    end
  end
end
