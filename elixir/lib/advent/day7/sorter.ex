defmodule Advent.Day7.Sorter do
  def sort(commands) do
    commands |> Enum.sort(&sorter/2)
  end

  defp sorter(a, b) do
    a_value = a |> last_value
    b_value = b |> last_value
    a_length = a_value |> atom_length
    b_length = b_value |> atom_length

    cond do
      a_value == b_value -> true
      a_length < b_length -> true
      a_length > b_length -> false
      a_length == b_length -> a_value < b_value
    end
  end

  defp last_value(tuple) do
    tuple |> Tuple.to_list |> List.last
  end

  defp atom_length(atom) do
    atom |> Atom.to_string |> String.length
  end
end
