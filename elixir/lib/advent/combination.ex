defmodule Advent.Combination do
  import Advent.List
  def all(stuff) do
    rots = rotations(stuff)

    Enum.reduce(rots, [], fn(rot, acc) -> all(rot, [], acc) end)
  end

  def all([item | tail], tracked, storage) do
    tracked = add_value_to_list(tracked, item)

    if Enum.count(tail) == 0 do
      add_value_to_list(storage, tracked)
    else
      rots = rotations(tail)

      Enum.reduce(rots, storage, fn(rot, acc) -> all(rot, tracked, acc) end)
    end
  end

  defp rotations([head | tail], generated \\ []) do
    value = [head] |> Enum.concat(tail)
    generated = generated |> add_value_to_list(value)

    if generated |> Enum.count == value |> Enum.count do
      generated
    else
      tail
      |> add_value_to_list(head)
      |> rotations(generated)
    end
  end
end
