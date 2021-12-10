require_relative "../base"

class Main < Base
  UNIQUE_LENGTHS = [2,3,4,7].freeze

  def part1
    count = 0
    input.each do |line|
      digits = parse_digits(line)
      digits.each do |digit|
        count += 1 if UNIQUE_LENGTHS.include?(digit.length)
      end
    end

    count
  end

  def part2
    numbers = []
    input.each_with_index do |line, idx|
      digits = parse_digits(line)
      hash = find_digits(line)
      numbers_hash = {}
      hash.map { |key, val| numbers_hash[val.sort.join("")] = key }
      numbers << digits.map do |digit|
        numbers_hash[digit.split("").sort.join("")]
      end.join("").to_i
    end

    numbers.reduce(:+)
  end

    private

      def parse_digits(line)
        line.split("|").last.strip.split(" ")
      end

      def find_digits(line)
        hash = {}
        digits = line.split("|").first.strip.split(" ")
        loop do
          digits.each do |digit|
            splitted = digit.split("")
            if digit.length == 2
              hash["1"] = splitted
            elsif digit.length == 3
              hash["7"] = splitted
            elsif digit.length == 4
              hash["4"] = splitted
            elsif digit.length == 7
              hash["8"] = splitted
            elsif nine?(hash["4"], digit)
              hash["9"] = splitted
            elsif three?(hash["9"], hash["1"], digit)
              hash["3"] = splitted
            elsif two?(hash["3"], hash["9"], digit)
              hash["2"] = splitted
            elsif five?(hash["9"], digit)
              hash["5"] = splitted
            elsif six?(hash["5"], digit)
              hash["6"] = splitted
            elsif zero?(hash["6"], digit)
              hash["0"] = splitted
            end
          end

          return hash if hash.length == 10
        end
      end

      def three?(nine, one, digit)
        return false unless one
        return false unless one.all? { |char| digit.include?(char) }

        nine &&
          digit.length == 5 &&
          digit.split("").all? { |char| nine.include?(char) }
      end

      def nine?(three, digit)
        three && digit.length == 6 && three.all? { |char| digit.include?(char) }
      end

      def two?(three, nine, digit)
        return false if !three || !nine

        shared_signals = three.select { |char| digit.include? char }.count
        in_nine = digit.split("").all? { |char| nine.include? char }
        digit.length == 5 && shared_signals == 4 && !in_nine
      end

      def five?(nine, digit)
        nine &&
          digit.length == 5 &&
          digit.split("").all? { |char| nine.include?(char) }
      end

      def six?(five, digit)
        five && digit.length == 6 && five.all? { |char| digit.include?(char) }
      end

      def zero?(six, digit)
        six && digit.length == 6
      end

      def prepare_input(input_file)
        File.read(input_file).split("\n")
      end
end

solver = Main.new("src/day8/input.txt")
puts "PART 1: #{solver.part1}"
puts "PART 2: #{solver.part2}"
