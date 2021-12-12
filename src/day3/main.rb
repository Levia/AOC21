require_relative "../base"

class Main < Base
  def part1
    gamma = ""
    epsilon = ""
    rows = input.length
    cols = input.first.length

    (0..cols-1).each do |col|
      counts = {"0" => 0, "1" => 0}
      (0..rows-1).each do |row|
        counts[input[row][col]] += 1
      end

      if counts["0"] > counts["1"]
        gamma << "0"
        epsilon << "1"
      else
        gamma << "1"
        epsilon << "0"
      end
    end

    gamma.to_i(2) * epsilon.to_i(2)
  end

  def part2
    oxygen = find_rating(:oxygen, 0, input)
    co2 = find_rating(:co2, 0, input)

    oxygen.to_i(2) * co2.to_i(2)
  end

  private

    def find_rating(type, bit_pos, numbers)
      return numbers.first if numbers.length == 1

      bit_value = select_bit(numbers, bit_pos, type)
      new_numbers = []
      numbers.each do |number|
        new_numbers << number if number[bit_pos] == bit_value
      end

      find_rating(type, bit_pos+1, new_numbers)
    end

    def select_bit(numbers, bit_pos, type)
      counts = {"0" => 0, "1" => 0}
      (0..numbers.length-1).each do |row|
        counts[numbers[row][bit_pos]] += 1
      end

      if counts["1"] >= counts["0"]
        type == :oxygen ? "1" : "0"
      else
        type == :oxygen ? "0" : "1"
      end
    end

    def prepare_input(input_file)
      File.readlines(input_file).map(&:strip)
    end
end

solver = Main.new("src/day3/input.txt")
puts "PART 1: #{solver.part1}"
puts "PART 2: #{solver.part2}"
