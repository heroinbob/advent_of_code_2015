defmodule Advent.List do
  def add_value_to_list(list, value) do
    list |> Enum.concat([value])
  end
end
