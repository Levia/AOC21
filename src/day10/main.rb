require_relative "../base"

class Main < Base
  attr_accessor :score

  SCORES = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
  }.freeze

  POINTS = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4
  }.freeze

  PARENTHESIS = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">"
  }.freeze

  def initialize(input_file)
    super input_file
    @score = 0
  end

  def part1
    input.each { |line| parenthesization(line) }
    score
  end

  def part2
    points = []
    input.each do |line|
      stack = parenthesization(line)
      next if stack == :corrupted || stack.empty?

      points << calculate_points(stack)
    end

    median points
  end

  private

    def median(array)
      return nil if array.empty?

      sorted = array.sort
      len = sorted.length
      (sorted[(len - 1) / 2] + sorted[len / 2]) / 2
    end


    def calculate_points(stack)
      points = 0
      stack.reverse.each do |char|
        points = (points * 5) + POINTS[PARENTHESIS[char]]
      end

      points
    end

    def parenthesization(line)
      return :corrupted if PARENTHESIS.values.include? line[0]

      corrupted = false
      stack = []
      line.split("").each do |char|
        if PARENTHESIS.keys.include?(char)
          stack << char
        else
          opening = stack.pop
          if PARENTHESIS[opening] != char
            @score += SCORES[char] unless corrupted
            corrupted = true
          end
        end
      end

      return :corrupted if corrupted

      stack
    end

    def prepare_input(input_file)
      File.readlines(input_file).map(&:strip)
    end
end

Main.solve("src/day10/input.txt")

