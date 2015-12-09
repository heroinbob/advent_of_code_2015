defmodule Advent.Day6.Command do
  def ranges(str) do
    x = Regex.scan(~r/\d+/, str) |> Enum.map(&convert_matches/1)
    {Enum.at(x, 0)..Enum.at(x, 2), Enum.at(x, 1)..Enum.at(x, 3)}
  end

  def convert_matches(list) do
    List.first(list) |> String.to_integer
  end

  def new(str) do
    action = Regex.run(~r/(on|off|toggle)/, str) |> List.first
    {action, ranges(str)}
  end

  def parse([str | tail], commands \\ []) do
    parse(tail, add(str, commands))
  end

  def parse([], commands) do
    commands |> Enum.reverse # preserve order!
  end

  def add(str, list) do
    str
    |> new
    |> List.wrap
    |> Enum.concat(list)
  end
end
