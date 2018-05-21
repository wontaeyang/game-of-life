module Gol
  class Cell
    attr_reader :x, :y

    def initialize(x: 0, y: 0, alive: false)
      # top left position in the environemnt
      @x = x
      @y = y
      validate_coordinates

      @alive = alive
    end

    def alive?
      alive
    end

    def dead?
      !alive
    end

    def revive!
      self.alive = true
    end

    def kill!
      self.alive = false
    end

    private

    attr_accessor :alive

    def validate_coordinates
      if x < 0 || y < 0
        raise InvalidValueError.new(
          "x or y position can not be less than 0"
        )
      end
    end
  end
end
