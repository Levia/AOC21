module Main
  class << self
    def part1(input_file)
      count = 0
      parse_input(input_file).inject do |prev, current|
        count += 1 if current > prev
        current
      end

      puts "Part 1: #{count}"
    end

    def part2(input_file)
      count = 0
      data = parse_input(input_file)
      (0..data.length-4).each do |idx|
        next if data.slice(idx+1, 3).reduce(:+) <= data.slice(idx, 3).reduce(:+)

        count += 1
      end

      puts "Part 2: #{count}"
    end

    private

      def parse_input(input)
        File.readlines(input).map(&:strip).map(&:to_i)
      end
  end
end

Main.part1("src/day1/input.txt")
Main.part2("src/day1/input.txt")
