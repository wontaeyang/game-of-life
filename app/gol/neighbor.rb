module Gol
  class Neighbor
    # coordinate offsets for each neighboring cells
    # [y_pos, x_pos]
    OFFSETS = [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],          [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1],
    ]

    attr_reader :environment

    def initialize(environment)
      @environment = environment
    end

    def count(cell)
      living_neighbor_count = 0

      OFFSETS.map do |offset|
        target_y = cell.y + offset[0]
        target_x = cell.x + offset[1]
        target_cell = environment.fetch_cell(target_x, target_y)

        if target_cell && target_cell.alive?
          living_neighbor_count += 1
        end
      end

      return living_neighbor_count
    end
  end
end
