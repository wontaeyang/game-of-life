module Gol
  class Neighbor
    attr_reader :cell, :neighbors, :layout

    def self.count(layout, cell)
      self.new(layout: layout, cell: cell).count
    end

    def initialize(layout:, cell:)
      @layout= layout
      @cell = cell
      @neighbors = []
    end

    def count
      find_neighbors
      count_live_neighboring_cells
    end

    def find_neighbors
      current_row = layout[pos_y]
      if current_row
        neighbors << current_row[pos_x - 1] #left
        neighbors << current_row[pos_x + 1] #right
      end

      top_row = layout[pos_y + 1]
      if top_row
        neighbors << top_row[pos_x] #top
        neighbors << top_row[pos_x - 1] #top left
        neighbors << top_row[pos_x + 1] #top right
      end

      bottom_row = layout[pos_y - 1]
      if bottom_row
        neighbors << bottom_row[pos_x] #bottom
        neighbors << bottom_row[pos_x - 1] #bottom left
        neighbors << bottom_row[pos_x + 1] #bottom right
      end

      # remove nil values
      neighbors.compact!
    end

    def count_live_neighboring_cells
      neighbors.select do |cell|
        cell.alive?
      end.count
    end

    private

    def pos_x
      @_pos_x ||= cell.x
    end

    def pos_y
      @_pos_y ||= cell.y
    end
  end
end
