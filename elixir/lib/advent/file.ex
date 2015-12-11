defmodule Advent.File do
  def lines(filename, splitter \\ "\n") do
    "data/#{filename}" |> File.read! |> String.split(splitter, trim: true)
  end

  def chars(filename) do
    {:ok, file} = File.open("data/#{filename}")
    data = IO.read(file, :all) |> String.strip
    File.close(file)

    data
  end
end
