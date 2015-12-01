#
# Day 1.
#
# == Part 1 ==
# Given a set of instructions that tell you to go up or down an elevator,
# determine the final floor you'll end up on!
#   - '(' is up 1 floor
#   - ')' is down 1 floor
#   - You start at floor 0 (ground).
#
# == Part 2 ==
# Determine at what position you'll be in the basement for the first time.
#   - First position is 1.
#
module AdventOfCode
  class SantasElevator
    MAP = { '(' => 1, ')' => -1 }

    attr_reader :instructions

    def initialize(instructions)
      @instructions = instructions
    end

    def destination
      instructions.count('(') - instructions.count(')')
    end

    def first_time_on(floor)
      sum = 0

      instructions.split('').each_with_index do |char, index|
        sum += MAP[char]

        return index + 1 if sum == floor
      end
    end
  end
end
