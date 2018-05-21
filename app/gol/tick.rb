module Gol
  class Tick
    attr_reader :environment, :neighbor
    attr_accessor :living_cells, :dying_cells

    def initialize(environment)
      @environment = environment
      @neighbor = Neighbor.new(environment)
      @living_cells = []
      @dying_cells = []
    end

    def update
      clear_cell_cache
      filter_by_rules
      apply_results!
    end

    def filter_by_rules
      environment.cells.each do |cell|
        count = neighbor.count(cell)

        apply_first_rule(cell, count)
        apply_second_rule(cell, count)
        apply_third_rule(cell, count)
        apply_fourth_rule(cell, count)
      end
    end

    private

    def apply_first_rule(cell, count)
      # Any live cell with fewer than two live neighbors dies,
      # as if caused by under population.

      if cell.alive? && count < 2
        dying_cells << cell
      end
    end

    def apply_second_rule(cell, count)
      # Any live cell with two or three live neighbors
      # lives on to the next generation.

      if cell.alive? && [2,3].include?(count)
        living_cells << cell
      end
    end

    def apply_third_rule(cell, count)
      # Any live cell with more than three live
      # neighbors dies, as if by overpopulation.

      if cell.alive? && count > 3
        dying_cells << cell
      end
    end

    def apply_fourth_rule(cell, count)
      # Any dead cell with exactly three live neighbors
      # becomes a live cell, as if by reproduction

      if cell.dead? && count == 3
        living_cells << cell
      end
    end

    def apply_results!
      living_cells.each do |cell|
        cell.revive!
      end

      dying_cells.each do |cell|
        cell.kill!
      end
    end

    def clear_cell_cache
      self.living_cells = []
      self.dying_cells = []
    end
  end
end
