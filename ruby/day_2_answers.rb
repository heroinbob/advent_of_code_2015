require './advent_of_code.rb'

dimensions = File.readlines('./data/day_2_dimensions.txt').
  map { |line| line.split('x').map(&:to_i) }

total = dimensions.inject({ paper: 0, ribbon: 0 }) do |sum, lwh|
  calculator = AdventOfCode::Calculator.new(lwh)

  sum[:paper] += calculator.total_paper
  sum[:ribbon] += calculator.total_ribbon
  sum
end

puts "You need #{total[:paper]} sq ft of paper, and #{total[:ribbon]} ft of ribbon!"
