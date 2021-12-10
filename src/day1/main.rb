require_relative "../base.rb"

class Main < Base
  def part1
    count = 0
    input.inject do |prev, current|
      count += 1 if current > prev
      current
    end

    count
  end

  def part2
    count = 0
    (0..input.length-4).each do |idx|
      next if input.slice(idx+1, 3).reduce(:+) <= input.slice(idx, 3).reduce(:+)

      count += 1
    end

    count
  end

  private

    def prepare_input(input)
      File.readlines(input).map(&:strip).map(&:to_i)
    end
end

Main.solve("src/day1/input.txt")

