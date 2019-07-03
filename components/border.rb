class Border

  def initialize
    
  end

  def draw
    @window.draw_rect(0, 0, 640, 480, Gosu::Color::WHITE)
    @window.draw_rect(2, 2, 636, 476, Gosu::Color::BLACK)
  end
end