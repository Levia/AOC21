require_relative "../base"

class Main < Base
  attr_reader :input

  def part1
    input.inject(0) { |sum, x| sum + (median-x).abs }
  end

  def part2
    mean_minus_one = (input.reduce(:+) - 1) / input.size
    mean_plus_one = (input.reduce(:+) + 1) / input.size
    minus_sum = input.inject(0) { |sum, x| sum + triangular(mean_minus_one, x) }
    plus_sum = input.inject(0) { |sum, x| sum + triangular(mean_plus_one, x) }
    [minus_sum, plus_sum].min
  end

  private

    def median
      sorted = input.sort
      len = sorted.length
      (sorted[(len - 1) / 2] + sorted[len / 2]) / 2
    end

    def triangular(mean, num)
      val = (num - mean).abs
      (val * (val + 1)) / 2
    end
end

solver = Main.new("src/day7/input.txt")
puts "Part 1: #{solver.part1}"
puts "Part 2: #{solver.part2}"
