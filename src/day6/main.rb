require_relative "../base"

class Main < Base
  def part1; calculate 80; end

  def part2; calculate 256; end

  private

    def calculate(days)
      input.tally.tap do |hash|
        days.times do
          generators = hash[0] || 0
          (1..8).to_a.each { |idx| hash[idx-1] = hash[idx] || 0 }
          hash[6] += generators
          hash[8] = generators || 0
        end
      end.values.reduce(:+)
    end

    def prepare_input(input_file)
      File.read(input_file).split(",").map(&:to_i)
    end
end

Main.solve("src/day6/input.txt")

