
require 'spec_helper'

describe ObjectPatch::Pointer, :focus do
  conversions = [
    [ [], '/' ],
    [ ['a/b'], '/a~1b' ],
    [ ['c%d'], '/c%d' ],
    [ ['e^f'], '/e^f' ],
    [ ['g|h'], '/g|h' ],
    [ ['i\\j'], '/i\\j' ],
    [ ['k\"l'], '/k\"l' ],
    [ [' '], '/ ' ],
    [ ['m~n'], '/m~0n' ],
    [ ['test', 1], '/test/1' ],
  ]

  conversions.each do |c|
    it "should encode #{c.first} as #{c.last}" do
      ObjectPatch::Pointer.encode(c.first).should eq(c.last)
    end
    
    it "should decode #{c.last} as #{c.first}" do
      ObjectPatch::Pointer.parse(c.last).should eq(c.first)
    end
  end
end

