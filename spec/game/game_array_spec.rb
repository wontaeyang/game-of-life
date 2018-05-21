require 'spec_helper'

describe Gol::CustomArray do
  describe "negative index" do
    it "does not wrap" do
      test_array = Gol::CustomArray.new([1,2,3,4])

      expect(test_array[-12]).to eq nil
    end
  end
end
