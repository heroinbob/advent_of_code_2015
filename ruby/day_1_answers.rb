require './advent_of_code.rb'

instructions = File.readlines('./data/day_1_directions.txt')[0].chomp
day1 = AdventOfCode::SantasElevator.new instructions
puts "The floor you end up on is #{day1.destination}"
puts "At #{day1.first_time_on(-1)} your enter the basement for the first time."
