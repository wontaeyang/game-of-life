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

    def fetch_cell(x, y)
      if x.between?(0, width - 1) && y.between?(0, height - 1)
        layout[y][x]
      else
        nil
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
      Array.new(height) { |pos_y|
        Array.new(width) { |pos_x|
          Cell.new(x: pos_x, y: pos_y)
        }
      }
    end
  end
end
