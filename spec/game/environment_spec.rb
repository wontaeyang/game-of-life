require 'spec_helper'

describe Gol::Environment do
  describe "#initialize" do
    it "assigns layout values" do
      env = Gol::Environment.new

      expect(env.width).to eq 100
      expect(env.height).to eq 100
    end

    it "populates cell layout" do
      env = Gol::Environment.new

      # check row count
      expect(env.layout.count).to eq 100

      # check cell count in a row
      first_row = env.layout.first
      expect(first_row.count).to eq 100

      # ceck cell type
      first_cell = first_row.first
      expect(first_cell.class).to eq Gol::Cell

      # check total cells
      expect(env.cells.count).to eq 100 * 100
    end
  end

  describe "validations" do
    it "does not allow dimension values less than 3" do
      expect{
        Gol::Environment.new(height: -12)
      }.to raise_error(
        Gol::InvalidValueError,
        "width and height must be greater than 3",
      )
    end
  end

  describe "#seed_random" do
    it "revives random cells" do
      env = Gol::Environment.new(width: 3, height:3)
      env.seed_random

      living_cells = env.cells.select {|cell| cell.alive?}

      expect(living_cells.count).to be > 0
    end
  end
end
