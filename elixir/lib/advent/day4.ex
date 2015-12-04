defmodule Advent.Day4 do
  @doc """
  --- Day 4: The Ideal Stocking Stuffer ---

  Santa needs help mining some AdventCoins (very similar to bitcoins) to use
  as gifts for all the economically forward-thinking little girls and boys.

  To do this, he needs to find MD5 hashes which, in hexadecimal, start with at
  least five zeroes. The input to the MD5 hash is some secret key (your puzzle
  input, given below) followed by a number in decimal. To mine AdventCoins,
  you must find Santa the lowest positive number (no leading zeroes: 1, 2, 3,
  ...) that produces such a hash.

  For example:

  If your secret key is abcdef, the answer is 609043, because the MD5 hash of
  abcdef609043 starts with five zeroes (000001dbbfa...), and it is the lowest
  such number to do so.

  If your secret key is pqrstuv, the lowest number it combines with to make an
  MD5 hash starting with five zeroes is 1048970; that is, the MD5 hash of
  pqrstuv1048970 looks like 000006136ef....

  Your puzzle input is bgvyzdsv.

  Example:
    iex> Advent.Day4.mine_for("abcdef")
    {609043, "000001DBBFA3A5C83A2D506429C7B00E"}

    iex> Advent.Day4.mine_for("pqrstuv")
    {1048970, "000006136EF2FF3B291C85725F17325C"}

  --- Part Two ---

  Now find one that starts with six zeroes.
  """
  def mine_for(key, expectation \\ "00000", count \\ 0) do
    x = md5("#{key}#{count}")

    if String.starts_with?(x, expectation) do
      {count, x}
    else
      mine_for(key, expectation, count + 1)
    end
  end

  @doc """
  Calculate the MD5 Hash in hexadecimal given the value.

  Example:
    iex> Advent.Day4.md5("abcdef609043")
    "000001DBBFA3A5C83A2D506429C7B00E"
  """
  def md5(key) do
    :crypto.hash(:md5, key) |> Base.encode16
  end
end
