class Snake
  attr_reader :head, :body, :xpos, :ypos

  def initialize(output)
    @output = output
    @head   = [1, 0]
    @body   = [[2, 2]]
    @key    = nil
  end

  def draw
    (@xpos, @ypos) = @body[0]
    (@xpos, @ypos) = [@xpos + @head[0], @ypos + @head[1]]

    exit if hit_self?

    @body.unshift [@xpos, @ypos]
    @output.(@xpos, @ypos, '█')
  end

  def hit_self?
    return @body.include?([@xpos, @ypos])
  end

  def outside_bounds?
    return (2..89).include?(@xpos) && (2..34).include?(@ypos) ? false : true
  end

  def ate_apple?(apple)
    return [@xpos, @ypos] == apple ? true : false           
  end

  def remove_tail!
    (@xpos, @ypos) = @body.pop
    @output.(@xpos, @ypos, ' ')                 
  end

  def bind_keys
    begin
      @key = STDIN.getc
      case @key
        when 'w' then @head = [ 0, -1] if @head != [ 0,  1] # up
        when 's' then @head = [ 0,  1] if @head != [ 0, -1] # down
        when 'a' then @head = [-1,  0] if @head != [ 1,  0] # left
        when 'd' then @head = [ 1,  0] if @head != [-1,  0] # right
      end
    end until @key == 'q' # q to quit
  end
end