defmodule Advent.Day10 do
  import Advent.List

  def look_and_say(value) do
    generate_lookups(value |> String.split("", trim: true))
  end

  def look_and_say(value, iteration_count) do
    Enum.reduce(
      1..iteration_count,
      value,
      fn(n, str) ->
        look_and_say(str)
      end
    )
  end

  def generate_lookups([value | tail], previous \\ "", count \\ 0, output \\ "") do
    if previous == "" do
      previous = value
    end

    if value != previous do
      output = output <> "#{count}#{previous}"
      previous = value
      count = 1
    else
      count = count + 1
      previous = value
    end

    generate_lookups(tail, previous, count, output)
  end

  def generate_lookups([], previous, count, output) do
    output <> "#{count}#{previous}"
  end
end
