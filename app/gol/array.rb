# This class is a modified array to return nil on
# negative index items.

module Gol
  class CustomArray < Array
    def [](i)
      if i >= 0
        super(i)
      else
        nil
      end
    end
  end
end
