class Base
  attr_reader :input

  def self.solve(input_file)
    new(input_file).print
  end

  def initialize(input_file)
    @input = prepare_input(input_file)
  end

  def part1; raise NotImplementedError; end

  def part2; raise NotImplementedError; end

  def print
    puts "PART 1: #{part1}"
    puts "PART 2: #{part2}"
  end

  private

    def prepare_input(input_file)
      raise NotImplementedError
    end
end
