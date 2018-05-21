require 'spec_helper'

describe Gol::Neighbor do
  let(:env) { Gol::Environment.new }
  let(:neighbor) { Gol::Neighbor.new(env) }

  describe "#count" do
    context "edge cell" do
      it "returns correct count" do
        cell = env.layout[0][0]
        test_cell = env.layout[0][1]
        test_cell.revive!

        count = neighbor.count(cell)

        expect(count).to eq 1
      end
    end

    context "surrounded cell" do
      it "returns correct neighbors" do
        cell = env.layout[1][1]
        test_cell_01= env.layout[2][1]
        test_cell_02 = env.layout[2][2]
        test_cell_01.revive!
        test_cell_02.revive!

        count = neighbor.count(cell)

        expect(count).to eq 2
      end
    end
  end
end
