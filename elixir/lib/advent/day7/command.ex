defmodule Advent.Day7.Command do
  def parse(strings) do
    strings |> Enum.map(&parser/1)
  end

  def parser(str) do
    str |> String.split(" ") |> List.to_tuple |> to_command
  end

  def to_command({op1, action, op2, _arrow, dest}) do
    {to_param(action), {to_param(op1), to_param(op2)}, to_param(dest)}
  end

  def to_command({"NOT", op, _arrow, dest}) do
    {:NOT, to_param(op), to_param(dest)}
  end

  def to_command({source, _arrow, dest}) do
    {:ASSIGN, to_param(source), to_param(dest)}
  end

  def to_param(value) do
    if String.match?(value, ~r/^\d+$/) do
      String.to_integer(value)
    else
      String.to_atom(value)
    end
  end
end
