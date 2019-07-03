require 'curses'
require_relative 'terminal_components/body'
require_relative 'terminal_components/border'
include Curses

class SnakeTerminal
  def initialize
    @score = 0
    @speed = 1
    @key   = nil
    @apple = [rand(2..89), rand(2..34)]

    @output = -> x, y, text { print "\033[#{y};#{x}f#{text}" }

    @snake = Body.new(@output)
    @border = Border.new(@output)
  end

  def start
    begin # will catch text pressed on terminal
      cbreak; noecho; curs_set(0)
      @border.draw

      Thread.abort_on_exception = true

      Thread.new do
        loop do
          @output.(40, 1, "score: #{@score}")
          @output.(@apple[0], @apple[1], '@')
          @output.(2,0, "Speed #{@speed}")
          @snake.draw
          
          if @snake.outside_bounds?
            exit
          end

          if @snake.ate_apple?(@apple)
            @score += 10
            @apple = [rand(2..89), rand(2..34)]
            @speed += 1  if @score % 500 == 0
          else
            @snake.remove_tail!
          end

          sleep 0.1 / @speed
        end
      end

      @snake.bind_keys
    ensure
      nocbreak; echo; curs_set(1)
    end
  end
end

snake = SnakeTerminal.new
snake.start