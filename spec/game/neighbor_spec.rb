require 'spec_helper'

describe Gol::Neighbor do
  describe "#count" do
    context "edge cell" do
      it "returns correct neighbors" do
        env = Gol::Environment.new
        cell = env.layout[0][0]
        counter = Gol::Neighbor.new(
          layout: env.layout,
          cell: cell,
        )
        count = counter.count

        expect(counter.neighbors.count).to eq 3
        expect(count).to eq 0
      end
    end

    context "surrounded cell" do
      it "returns correct neighbors" do
        env = Gol::Environment.new
        cell = env.layout[1][1]
        counter = Gol::Neighbor.new(
          layout: env.layout,
          cell: cell,
        )
        count = counter.count

        expect(counter.neighbors.count).to eq 8
        expect(count).to eq 0
      end
    end

    context "count of activated cells" do
      it "returns correct count" do
        env = Gol::Environment.new
        cell = env.layout[1][1]
        neighbor_01 = env.layout[2][1]
        neighbor_02 = env.layout[2][2]
        neighbor_01.revive!
        neighbor_02.revive!

        count = Gol::Neighbor.count(env.layout, cell)

        expect(count).to eq 2
      end
    end
  end
end
