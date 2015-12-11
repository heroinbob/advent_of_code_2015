defmodule Advent.Day7 do
  alias Advent.Day7.Command
  alias Advent.Day7.Sorter
  alias Advent.Day7.Computer
  alias Advent.File
  @doc """
  --- Day 7: Some Assembly Required ---

  This year, Santa brought little Bobby Tables a set of wires and bitwise logic
  gates! Unfortunately, little Bobby is a little under the recommended age
  range, and he needs help assembling the circuit.

  Each wire has an identifier (some lowercase letters) and can carry a 16-bit
  signal (a number from 0 to 65535). A signal is provided to each wire by a
  gate, another wire, or some specific value. Each wire can only get a signal
  from one source, but can provide its signal to multiple destinations. A gate
  provides no signal until all of its inputs have a signal.

  The included instructions booklet describes how to connect the parts
  together: x AND y -> z means to connect wires x and y to an AND gate, and
  then connect its output to wire z.

  For example:

  123 -> x means that the signal 123 is provided to wire x.

  x AND y -> z means that the bitwise AND of wire x and wire y is provided to
  wire z.

  p LSHIFT 2 -> q means that the value from wire p is left-shifted by 2 and
  then provided to wire q.

  NOT e -> f means that the bitwise complement of the value from wire e is
  provided to wire f.

  Other possible gates include OR (bitwise OR) and RSHIFT (right-shift). If,
  for some reason, you'd like to emulate the circuit instead, almost all
  programming languages (for example, C, JavaScript, or Python) provide
  operators for these gates.

  For example, here is a simple circuit:

  123 -> x
  456 -> y
  x AND y -> d
  x OR y -> e
  x LSHIFT 2 -> f
  y RSHIFT 2 -> g
  NOT x -> h
  NOT y -> i
  After it is run, these are the signals on the wires:

  d: 72
  e: 507
  f: 492
  g: 114
  h: 65412
  i: 65079
  x: 123
  y: 456

  In little Bobby's kit's instructions booklet (provided as your puzzle
  input), what signal is ultimately provided to wire a?
  """
  def commands do
    File.lines("day7.txt") |> Command.parse
  end

  def sorted_commands(sorter_type \\ Sorter) do
    commands |> sorter_type.sort
  end

  def compute(commands, override \\ {:none}) do
    commands
    |> Enum.drop(1)
    |> override_signal(override)
    |> Enum.reduce(
      HashDict.new,
      fn(command, hash) ->
        {_action, _opts, dest} = command
        hash |> store(dest, Computer.compute(command, hash))
      end
    )
  end

  @doc """
  Return the signal that will be sent on wire A.
  iex> Advent.Day7.sorted_commands |> Advent.Day7.a_signal
  16076

  iex> Advent.Day7.sorted_commands |> Advent.Day7.a_signal({:start_with, 16076})
  2797
  """
  def a_signal(commands, override \\ {:none}) do
    key = commands |> source_key_for_a
    commands |> compute(override) |> HashDict.get(key)
  end

  def store(hash, key, value) do
    HashDict.put(hash, key, value)
  end

  def source_key_for_a(commands) do
    commands |> List.first |> Tuple.to_list |> Enum.at(1)
  end

  def override_signal(commands, {:start_with, signal}) do
    commands |> List.replace_at(0, {:ASSIGN, signal, :b})
  end

  def override_signal(commands, {:none}) do
    commands
  end
end
