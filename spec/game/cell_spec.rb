require 'spec_helper'

describe Gol::Cell do
  describe "#initialize" do
    it "assigns default values" do
      cell = Gol::Cell.new

      expect(cell.x).to eq 0
      expect(cell.y).to eq 0
      expect(cell.alive?).to eq false
    end
  end

  describe "validations" do
    it "does not allow dimension values less than 0" do
      expect{
        Gol::Cell.new(y: -100)
      }.to raise_error(
        Gol::InvalidValueError,
        "x or y position can not be less than 0",
      )
    end
  end

  describe "#activated?" do
    it "returns status of activation" do
      cell = Gol::Cell.new(alive: true)

      result = cell.alive?

      expect(result).to eq true
    end
  end

  describe "#dead?" do
    it "returns status of termination" do
      cell = Gol::Cell.new(alive: false)

      result = cell.dead?

      expect(result).to eq true
    end
  end

  describe "#revive!" do
    it "changes activated status to true" do
      cell = Gol::Cell.new(alive: false)

      cell.revive!

      expect(cell.alive?).to eq true
    end
  end

  describe "#kill!" do
    it "changes activated status to false" do
      cell = Gol::Cell.new(alive: true)

      cell.kill!

      expect(cell.alive?).to eq false
    end
  end
end
