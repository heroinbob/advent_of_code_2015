defmodule Advent.File do
  def split_file(filename, splitter \\ "\n") do
    "data/#{filename}" |> File.read! |> String.split(splitter, trim: true)
  end
end
