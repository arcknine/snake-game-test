class Segment

  attr_accessor :xpos, :ypos
  def initialize(snake, window, position)
    @window = window
    @xpos = position[0]
    @ypos = position[1]
  end

  def draw
    @window.draw_quad(@xpos,@ypos,Gosu::Color::GREEN,@xpos + 10,@ypos,Gosu::Color::GREEN,@xpos,@ypos + 10,Gosu::Color::GREEN,@xpos + 10,@ypos + 10,Gosu::Color::GREEN)
  end

end