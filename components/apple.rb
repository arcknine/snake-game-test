class Apple

  attr_reader :xpos, :ypos

  def initialize(window)
    @window = window
    @xpos = rand(10..630)
    @ypos = rand(50..470)
  end

  def draw
    @window.draw_quad(@xpos,@ypos,Gosu::Color::RED,@xpos,@ypos + 10,Gosu::Color::RED,@xpos + 10,@ypos,Gosu::Color::RED,@xpos + 10,@ypos + 10, Gosu::Color::RED)
  end
end