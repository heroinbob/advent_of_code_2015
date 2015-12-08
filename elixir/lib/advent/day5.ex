defmodule Advent.Day5 do
  def list do
    File.read!("data/day5.txt") |> String.split("\n")
  end

  @doc """
  Count how many entries are considered "nice"

    iex> Advent.Day5.nice_count
    258
  """
  def nice_count do
    list |> Enum.count(fn(str) -> nice?(str) end)
  end

  @doc """
  Count how many entries are considered "nice"

    iex> Advent.Day5.nicer_count
    53
  """
  def nicer_count do
    list |> Enum.count(fn(str) -> nicer?(str) end)
  end

  @doc """
  Santa needs help figuring out which strings in his text file are naughty or
  nice.

  A nice string is one with all of the following properties:

  It contains at least three vowels (aeiou only), like aei, xazegov, or
  aeiouaeiouaeiou.

  It contains at least one letter that appears twice in a row, like xx, abcdde
  (dd), or aabbccdd (aa, bb, cc, or dd).

  It does not contain the strings ab, cd, pq, or xy, even if they are part of
  one of the other requirements.

  For example:

  iex> Advent.Day5.nice?("ugknbfddgicrmopn")
  true

  iex> Advent.Day5.nice?("aaa")
  true

  iex> Advent.Day5.nice?("jchzalrnumimnmhp")
  false

  iex> Advent.Day5.nice?("haegwjzuvuyypxyu")
  false

  iex> Advent.Day5.nice?("dvszwmarrgswjxmb")
  false

  How many strings are nice?
  """
  def nice?(str) do
    three_vowels?(str) && double_char?(str) && !bad?(str)
  end

  @doc """
  Returns true if the string is "nice" according to a "better" set of rules.

  iex> Advent.Day5.nicer?("qjhvhtzxzqqjkmpb")
  true

  iex> Advent.Day5.nicer?("xxyxx")
  true

  iex> Advent.Day5.nicer?("uurcxstgmygtbstg")
  false

  iex> Advent.Day5.nicer?("ieodomkazucvgmuy")
  false
  """
  def nicer?(str) do
    doubles?(str) && sandwich?(str)
  end

  @doc """
  Returns true if the string has 3 vowels in it.
  Example:
    iex> Advent.Day5.three_vowels?("abcdefghi")
    true

    iex> Advent.Day5.three_vowels?("Nope")
    false
  """
  def three_vowels?(str) do
    str
    |> String.replace(~r/[^aeiou]/, "")
    |> String.length >= 3
  end

  @doc """
  Returns true if the string contains two of the same char in sequence.
  Example:
    iex> Advent.Day5.double_char?("something")
    false

    iex> Advent.Day5.double_char?("sommething")
    true
  """
  def double_char?(str) do
    String.match?(str, ~r/(.)\1{1,}/)
  end

  @doc """
  Returns true if the string contains any bad char sequences.
  Example:
    iex> Advent.Day5.bad?("zwabw")
    true

    iex> Advent.Day5.bad?("xxxcdyyy")
    true

    iex> Advent.Day5.bad?("xxxpqyyy")
    true

    iex> Advent.Day5.bad?("xxxxyyy")
    true

    iex> Advent.Day5.bad?("badcqpyx")
    false
  """
  def bad?(str) do
    String.match?(str, ~r/ab|cd|pq|xy/)
  end

  @doc """
  Returns true if the string contains a pattern where one char repeats with
  any other char in the middle.

  iex> Advent.Day5.sandwich?("xyx")
  true

  iex> Advent.Day5.sandwich?("abcdefeghi")
  true

  iex> Advent.Day5.sandwich?("aaa")
  true

  iex> Advent.Day5.sandwich?("aab")
  false

  iex> Advent.Day5.sandwich?("abba")
  false
  """
  def sandwich?(str) do
    String.match?(str, ~r/(.).\1/)
  end

  @doc """
  Returns true if there are no overlapping double patterns.

    iex> Advent.Day5.doubles?("xyxy")
    true

    iex> Advent.Day5.doubles?("aabcdefgaa")
    true

    iex> Advent.Day5.doubles?("aaa")
    false
  """
  def doubles?(str) do
    String.match?(str, ~r/(.)(.).*\1\2/)
  end
end
