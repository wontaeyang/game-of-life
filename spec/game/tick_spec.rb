require 'spec_helper'

describe Gol::Tick do
  describe "#execute" do
    context "first rule" do
      it "kills the live cell with less than two neighbors" do
        env = Gol::Environment.new(width: 3, height: 3)
        cell = env.layout[1][1]
        cell.revive!

        Gol::Tick.new(env).update

        expect(cell.dead?).to eq true
      end
    end

    context "second rule" do
      it "keeps live cell with 2 or 3 live neigbors alive" do
        env = Gol::Environment.new(width: 3, height: 3)
        cell = env.layout[1][1]
        cell.revive!
        env.layout[0][0].revive!
        env.layout[0][1].revive!

        Gol::Tick.new(env).update

        expect(cell.alive?).to eq true
      end
    end

    context "third rule" do
      it "kills live cell with more than 3 live neighbor" do
        env = Gol::Environment.new(width: 3, height: 3)
        cell = env.layout[1][1]
        cell.revive!
        env.layout[0][0].revive!
        env.layout[0][1].revive!
        env.layout[0][2].revive!
        env.layout[1][0].revive!

        Gol::Tick.new(env).update

        expect(cell.alive?).to eq false
      end
    end

    context "fourth rule" do
      it "revives dead cell with 3 live neighbor" do
        env = Gol::Environment.new(width: 3, height: 3)
        cell = env.layout[1][1]
        cell.kill!

        env.layout[0][0].revive!
        env.layout[0][1].revive!
        env.layout[0][2].revive!

        Gol::Tick.new(env).update

        expect(cell.alive?).to eq true
      end
    end
  end
end
