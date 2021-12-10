require_relative "../base"

class Main < Base
  def part1
    @distance = @depth = 0
    input.each { |instruction| work_instruction(instruction) }

    @distance * @depth
  end

  def part2
    @distance = @depth = @aim = 0
    input.each { |instruction| work_instruction(instruction, with_aim: true) }

    @distance * @depth
  end

  private

    def work_instruction(instruction, with_aim: false)
      direction, amount = instruction.split(" ")
      case direction
      when "forward"
        @distance += amount.to_i
        @depth += @aim * amount.to_i if with_aim
      when "down"
        with_aim ? @aim += amount.to_i : @depth += amount.to_i
      when "up"
        with_aim ? @aim -= amount.to_i : @depth -= amount.to_i
      end
    end

    def prepare_input(input_file)
      File.readlines(input_file).map(&:strip)
    end
end

solver = Main.new("src/day2/input.txt")
puts "PART 1: #{solver.part1}"
puts "PART 2: #{solver.part2}"

