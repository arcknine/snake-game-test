class Border
  def initialize(output)
    @output = output
  end

  def draw
    # clear screen
    print "\033[2J"

    # print border
    (1..35).to_a.product([1, 90]).each { |y, x| @output.(x, y, '|') }
    (1..90).to_a.product([1, 35]).each { |x, y| @output.(x, y, '-') }
  end
end