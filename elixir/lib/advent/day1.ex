# Santa is trying to deliver presents in a large apartment building, but he
# can't find the right floor - the directions he got are a little confusing. He
# starts on the ground floor (floor 0) and then follows the instructions one
# character at a time.
#
# An opening parenthesis, (, means he should go up one floor, and a closing
# parenthesis, ), means he should go down one floor.
#
# The apartment building is very tall, and the basement is very deep; he will
# never find the top or bottom floors.
#
# For example:
#
# (()) and ()() both result in floor 0.
# ((( and (()(()( both result in floor 3.
# ))((((( also results in floor 3.
# ()) and ))( both result in floor -1 (the first basement level).
# ))) and )())()) both result in floor -3.
# To what floor do the instructions take Santa?
#
# --- Part Two ---
#
# Now, given the same instructions, find the position of the first character
# that causes him to enter the basement (floor -1). The first character in
# the instructions has position 1, the second character has position 2,
# and so on.
#
# For example:
#
#) causes him to enter the basement at character position 1.
# ()()) causes him to enter the basement at character position 5.
# What is the position of the character that causes Santa to first enter the
# basement?
defmodule Advent.Day1 do
  def floor(commands) do
    up_count(commands) - down_count(commands)
  end

  def up_count(commands) do
    ups = String.replace(commands, ")", "")
    String.length(ups)
  end

  def down_count(commands) do
    downs = String.replace(commands, "(", "")
    String.length(downs)
  end

  def first_on(target_floor, commands, index \\ 0, current_floor \\ 0) do
    command = String.at(commands, index)
    new_floor = current_floor + move(command)

    if new_floor == target_floor do
      index + 1
    else
      new_index = index + 1

      first_on(target_floor, commands, new_index, new_floor)
    end
  end

  def move(command) do
    if command == "(" do
      1
    else
      -1
    end
  end
end
