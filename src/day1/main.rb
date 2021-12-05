module Main
  class << self
    def run(input_file)
      count = 0
      parse_input(input_file).inject do |prev, current|
        count += 1 if current > prev
        current
      end

      puts count
    end

    private

      def parse_input(input)
        File.readlines(input).map(&:strip).map(&:to_i)
      end
  end
end

Main.run("src/day1/input.txt")
