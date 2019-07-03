
require 'gosu'
require_relative 'components/apple'
require_relative 'components/body'
require_relative 'components/border'
require_relative 'components/segment'

class Snake < Gosu::Window
	def initialize
		super 640, 480, false
		self.caption = "Snake Test"
		@body   = Body.new(self)
		@apple  = Apple.new(self)
		@border = Border.new(self)
		@score  = 0

		@text_object = Gosu::Font.new(self, 'Comic Sans', 32)
	end

	def update
		if button_down?(Gosu::KbLeft) and @body.direction != "right"
			@body.direction = "left"
		elsif button_down?(Gosu::KbRight) and @body.direction != "left"
			@body.direction = "right"
		elsif button_down?(Gosu::KbUp) and @body.direction != "down"
			@body.direction = "up"
		elsif button_down?(Gosu::KbDown) and @body.direction != "up"
			@body.direction = "down"
		elsif button_down?(Gosu::KbEscape)
			self.close
		end

		if @body.ate_apple?(@apple)
			@apple = Apple.new(self)
			@score += 10
			@body.length += 10
			
			@body.ticker += 11
			if @score % 100 == 0 # increase speed every 100 score
				@body.speed += 0.5
			end
		end

		if @body.hit_self?
			@new_game = Gosu::Font.new(self, 'Comic Sans', 32)
		end

		if @body.outside_bounds?
			@new_game = Gosu::Font.new(self, 'Comic Sans', 32)
		end

		if @new_game and button_down?(Gosu::KbReturn)
			@new_game = nil
			@score = 0
			@body = Body.new(self)
			@apple = Apple.new(self)
		end

		@body.ticker -= 1 if @body.ticker > 0
	end

	def draw
		if @new_game
			@new_game.draw("Your Score was #{@score}", 5, 200, 100)
			@new_game.draw("Hit Return to Try Again", 5, 250, 100)
			@new_game.draw("Or Escape to Close", 5, 300, 100)
		else
			@body.update_position
			@border.draw
			@body.draw
			@apple.draw
			@text_object.draw("Score: #{@score}",5,5,0)
		end
	end
end

snake = Snake.new
snake.show