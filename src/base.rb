class Base
  attr_reader :input

  def initialize(input_file)
    @input = prepare_input(input_file)
  end

  private

    def prepare_input(input_file)
      File.read(input_file).split(",").map(&:to_i)
    end
end
