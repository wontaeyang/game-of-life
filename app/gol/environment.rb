module Gol
  class Environment
    attr_reader :width, :height, :layout, :cells

    def initialize(height: 100, width: 100)
      # cell grid dimenstions
      @height = height
      @width = width
      validate_dimensions

      @layout = setup_layout
      @cells = layout.flatten
    end

    def seed_random
      cells.each do |cell|
        if [true, false].sample
          cell.revive!
        end
      end
    end


    private

    def validate_dimensions
      if width < 3 || height < 3
        raise InvalidValueError.new(
          "width and height must be greater than 3"
        )
      end
    end

    def setup_layout
      CustomArray.new(height) { |pos_y|
        CustomArray.new(width) { |pos_x|
          Cell.new(x: pos_x, y: pos_y)
        }
      }
    end
  end
end
