defmodule Advent.Day7 do
  # Assignment is {value, dest}
  # Command should be {{x, y, action}, dest}

  # sort commands...
  #  - all pure "assignment" commands first
  #    list |> Enum.filter(fn(v) -> String.match?(v, ~r/^\d+ -> \w/)
  #    ["19138 -> b", "0 -> c"]

  #  - Now sort by alphabetical destination...
  #  - Enum.sort(commands), fn(a, b) -> a < b end)
end
